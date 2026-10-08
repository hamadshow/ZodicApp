import 'package:flutter/material.dart';

import 'text_input.dart';

/// Number input for numeric values.
class AppNumberInput extends StatelessWidget {
  const AppNumberInput({
    super.key,
    required this.label,
    this.hint = 'Enter number',
    this.controller,
    this.isRequired = false,
    this.errorText,
    this.onChanged,
    this.allowDecimals = false,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isRequired;
  final String? errorText;
  final Function(String)? onChanged;
  final bool allowDecimals;

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return isRequired ? 'Number is required' : null;
    }
    try {
      if (allowDecimals) {
        double.parse(value);
      } else {
        int.parse(value);
      }
    } catch (e) {
      return 'Please enter a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      label: label,
      hint: hint,
      controller: controller,
      prefixIcon: Icons.numbers_outlined,
      keyboardType: allowDecimals ? TextInputType.number : TextInputType.number,
      isRequired: isRequired,
      errorText: errorText,
      validator: _validateNumber,
      onChanged: onChanged,
    );
  }
}
