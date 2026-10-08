import 'package:flutter/material.dart';

import 'text_input.dart';

/// Email input with email validation.
class AppEmailInput extends StatelessWidget {
  const AppEmailInput({
    super.key,
    required this.label,
    this.hint = 'Enter email address',
    this.controller,
    this.isRequired = false,
    this.errorText,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isRequired;
  final String? errorText;
  final Function(String)? onChanged;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return isRequired ? 'Email is required' : null;
    }
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      label: label,
      hint: hint,
      controller: controller,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      isRequired: isRequired,
      errorText: errorText,
      validator: _validateEmail,
      onChanged: onChanged,
    );
  }
}
