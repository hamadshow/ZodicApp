import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../buttons/primary_button.dart';

/// Error dialog for displaying errors.
class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
  });

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
      title: Text(title),
      content: Text(message),
      actions: [
        AppPrimaryButton(
          text: buttonText,
          onPressed: onDismiss ?? () => Navigator.pop(context),
          isFullWidth: false,
        ),
      ],
    );
  }
}
