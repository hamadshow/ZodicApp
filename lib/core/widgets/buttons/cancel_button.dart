import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_spacing.dart';

/// Button used in form contexts for canceling/closing dialogs.
class AppCancelButton extends StatelessWidget {
  const AppCancelButton({
    super.key,
    required this.onPressed,
    this.width,
    this.label = 'Cancel',
  });

  final VoidCallback? onPressed;
  final double? width;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(AppSpacing.inputHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.md,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
