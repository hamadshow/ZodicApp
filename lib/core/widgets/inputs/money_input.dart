import 'package:flutter/material.dart';

import 'text_input.dart';

/// Money/currency input for financial values.
class AppMoneyInput extends StatelessWidget {
  const AppMoneyInput({
    super.key,
    required this.label,
    this.hint = '0.00',
    this.controller,
    this.isRequired = false,
    this.errorText,
    this.onChanged,
    this.currencySymbol = '\$',
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isRequired;
  final String? errorText;
  final Function(String)? onChanged;
  final String currencySymbol;

  String? _validateMoney(String? value) {
    if (value == null || value.isEmpty) {
      return isRequired ? 'Amount is required' : null;
    }
    try {
      double.parse(value);
    } catch (e) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      label: label,
      hint: hint,
      controller: controller,
      prefixIcon: Icons.attach_money_rounded,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      isRequired: isRequired,
      errorText: errorText,
      validator: _validateMoney,
      onChanged: onChanged,
    );
  }
}
