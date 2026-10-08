import 'package:flutter/material.dart';

import '../../../core/widgets/buttons/primary_button.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_header.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.controller,
    required this.onBackToLogin,
  });

  final AuthController controller;
  final VoidCallback onBackToLogin;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    final trimmed = value ?? '';
    if (trimmed.isEmpty) {
      return 'This field is required.';
    }
    if (trimmed.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'This field is required.';
    }
    if (_newPasswordController.text != value) {
      return 'Passwords do not match.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final resetSuccess = await widget.controller.resetPassword(
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!mounted) return;
    if (resetSuccess) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
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
                title: 'Reset Password',
                subtitle: 'Create a new password for your account.',
                showBackButton: true,
                onBack: widget.onBackToLogin,
              ),
              const SizedBox(height: 28),
              AuthFormContainer(
                child: success
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_rounded, size: 56, color: Colors.green),
                          const SizedBox(height: 16),
                          Text(
                            'Password Reset Successfully',
                            style: Theme.of(context).textTheme.titleLarge,
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
                              controller: _newPasswordController,
                              obscureText: !_newPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                hintText: 'Enter new password',
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => _newPasswordVisible = !_newPasswordVisible),
                                  icon: Icon(
                                    _newPasswordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  ),
                                ),
                              ),
                              validator: _validatePassword,
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !_confirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm your password',
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                                  icon: Icon(
                                    _confirmPasswordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  ),
                                ),
                              ),
                              validator: _validateConfirmPassword,
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
                              text: widget.controller.isLoading ? 'Resetting...' : 'Reset Password',
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
