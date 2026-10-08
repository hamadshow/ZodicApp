import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../buttons/primary_button.dart';
import '../buttons/outline_button.dart';

/// Confirmation dialog for user confirmations.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
    this.icon = Icons.help_outline_rounded,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(icon, size: 48, color: AppColors.primary),
      title: Text(title),
      content: Text(message),
      actions: [
        AppOutlineButton(
          text: cancelText,
          onPressed: onCancel ?? () => Navigator.pop(context),
          isFullWidth: false,
        ),
        const SizedBox(width: AppSpacing.md),
        AppPrimaryButton(
          text: confirmText,
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          isFullWidth: false,
        ),
      ],
    );
  }
}
