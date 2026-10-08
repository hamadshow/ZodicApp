import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Dashboard card for displaying page widgets.
class AppDashboardCard extends StatelessWidget {
  const AppDashboardCard({
    super.key,
    this.title,
    required this.child,
    this.trailing,
    this.onTap,
  });

  final String? title;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              if (title != null) const SizedBox(height: AppSpacing.lg),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
