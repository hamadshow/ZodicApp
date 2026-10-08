import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Chip widget for tags, filters, or selections.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.onPressed,
    this.isSelected = false,
  });

  final String label;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      onDeleted: onDeleted,
      backgroundColor: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainer,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textPrimary,
      ),
    );
  }
}
