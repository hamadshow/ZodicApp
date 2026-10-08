import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_spacing.dart';

/// Badge widget for displaying counts or labels.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.error,
    this.textColor = Colors.white,
    this.size = 'small',
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final String size;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == 'small';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? AppSpacing.sm : AppSpacing.md,
        vertical: isSmall ? AppSpacing.xs : AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: isSmall ? 12 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
