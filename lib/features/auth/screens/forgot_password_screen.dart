import 'package:flutter/material.dart';

import '../../../core/widgets/buttons/primary_button.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    required this.controller,
    required this.onBackToLogin,
  });

  final AuthController controller;
  final VoidCallback onBackToLogin;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'This field is required.';
    }
    if (!trimmed.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final sent = await widget.controller.sendResetLink(email: _emailController.text.trim());
    if (!mounted) return;
    if (sent) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final success = widget.controller.state == AuthFlowState.success && widget.controller.message != null;

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(
                title: 'Forgot Password?',
                subtitle: 'Enter your email address and we will send you instructions to reset your password.',
                showBackButton: true,
                onBack: widget.onBackToLogin,
              ),
              const SizedBox(height: 28),
              AuthFormContainer(
                child: success
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.mark_email_read_outlined, size: 56, color: Colors.green),
                          const SizedBox(height: 16),
                          Text(
                            'Reset link sent',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check your email for instructions to reset your password.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                          AppPrimaryButton(
                            text: 'Back to Login',
                            onPressed: widget.onBackToLogin,
                            width: double.infinity,
                          ),
                        ],
                      )
                    : Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'you@example.com',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 18),
                            if (widget.controller.hasError && widget.controller.message != null) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  widget.controller.message!,
                                  style: TextStyle(color: Colors.red.shade700),
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],
                            AppPrimaryButton(
                              text: widget.controller.isLoading ? 'Sending...' : 'Send Reset Link',
                              onPressed: widget.controller.isLoading ? null : _submit,
                              isLoading: widget.controller.isLoading,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
