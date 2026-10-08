import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CollapseButton extends StatelessWidget {
  const CollapseButton({
    super.key,
    required this.isCollapsed,
    required this.onPressed,
  });

  final bool isCollapsed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          isRtl
              ? (isCollapsed ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded)
              : (isCollapsed ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded),
          size: 18,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
