import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Custom divider widget.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height = 1,
    this.color = AppColors.border,
    this.margin = EdgeInsets.zero,
  });

  final double height;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      color: color,
    );
  }
}
