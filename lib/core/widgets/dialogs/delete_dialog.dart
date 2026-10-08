import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../buttons/danger_button.dart';
import '../buttons/outline_button.dart';

/// Delete confirmation dialog.
class AppDeleteDialog extends StatelessWidget {
  const AppDeleteDialog({
    super.key,
    required this.title,
    this.message = 'This action cannot be undone.',
    this.confirmText = 'Delete',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_outline_rounded, size: 48, color: AppColors.error),
      title: Text(title),
      content: Text(message),
      actions: [
        AppOutlineButton(
          text: cancelText,
          onPressed: onCancel ?? () => Navigator.pop(context),
          isFullWidth: false,
        ),
        const SizedBox(width: AppSpacing.md),
        AppDangerButton(
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
