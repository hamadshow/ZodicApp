import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Icon button for edit/pencil actions.
class AppEditButton extends StatelessWidget {
  const AppEditButton({
    super.key,
    required this.onPressed,
    this.tooltip = 'Edit',
    this.size = 24,
  });

  final VoidCallback? onPressed;
  final String tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit_outlined, size: size),
      onPressed: onPressed,
      tooltip: tooltip,
      color: AppColors.primary,
      disabledColor: AppColors.textDisabled,
    );
  }
}
