import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Currency text widget for displaying formatted currency values.
class AppCurrencyText extends StatelessWidget {
  const AppCurrencyText({
    super.key,
    required this.amount,
    this.currencySymbol = '\$',
    this.textStyle,
    this.color,
  });

  final double amount;
  final String currencySymbol;
  final TextStyle? textStyle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final formatted = '$currencySymbol${amount.toStringAsFixed(2)}';
    return Text(
      formatted,
      style: (textStyle ?? Theme.of(context).textTheme.bodyMedium)?.copyWith(
        color: color ?? AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
