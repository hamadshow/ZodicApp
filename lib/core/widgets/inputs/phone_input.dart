import 'package:flutter/material.dart';

import 'text_input.dart';

/// Phone number input with phone validation.
class AppPhoneInput extends StatelessWidget {
  const AppPhoneInput({
    super.key,
    required this.label,
    this.hint = 'Enter phone number',
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

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return isRequired ? 'Phone number is required' : null;
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      label: label,
      hint: hint,
      controller: controller,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      isRequired: isRequired,
      errorText: errorText,
      validator: _validatePhone,
      onChanged: onChanged,
    );
  }
}
