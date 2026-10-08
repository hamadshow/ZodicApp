import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../buttons/primary_button.dart';

/// Warning dialog for alerting users.
class AppWarningDialog extends StatelessWidget {
  const AppWarningDialog({
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
      icon: const Icon(Icons.warning_outlined, size: 48, color: AppColors.warning),
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
