import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Icon button for delete/trash actions.
class AppDeleteButton extends StatelessWidget {
  const AppDeleteButton({
    super.key,
    required this.onPressed,
    this.tooltip = 'Delete',
    this.size = 24,
  });

  final VoidCallback? onPressed;
  final String tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete_outline_rounded, size: size),
      onPressed: onPressed,
      tooltip: tooltip,
      color: AppColors.error,
      disabledColor: AppColors.textDisabled,
    );
  }
}
