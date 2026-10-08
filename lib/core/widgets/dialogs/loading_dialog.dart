import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Loading dialog with progress indicator.
class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({
    super.key,
    this.message = 'Loading...',
    this.isDismissible = false,
  });

  final String message;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isDismissible,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.lg),
            Text(message),
          ],
        ),
      ),
    );
  }
}
