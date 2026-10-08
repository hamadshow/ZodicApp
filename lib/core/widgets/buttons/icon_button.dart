import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Icon button with consistent styling across the app.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 24,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      tooltip: tooltip,
      color: color ?? AppColors.textPrimary,
      disabledColor: AppColors.textDisabled,
    );
  }
}
