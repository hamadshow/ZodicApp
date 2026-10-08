import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_radius.dart';

/// Floating Action Button matching the app design system.
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.heroTag,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      tooltip: tooltip,
      heroTag: heroTag,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.xl,
      ),
      child: Icon(icon),
    );
  }
}
