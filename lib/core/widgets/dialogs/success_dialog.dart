import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../buttons/primary_button.dart';

/// Success dialog for confirming successful actions.
class AppSuccessDialog extends StatelessWidget {
  const AppSuccessDialog({
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
      icon: const Icon(Icons.check_circle_outline_rounded, size: 48, color: AppColors.success),
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
