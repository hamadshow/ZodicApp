import 'package:flutter/material.dart';

import '../../../app_shell/navigation_item.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import 'sidebar_item.dart';

class SidebarGroup extends StatelessWidget {
  const SidebarGroup({
    super.key,
    required this.title,
    required this.items,
    required this.currentRoute,
    required this.isCollapsed,
    required this.expandedState,
    required this.onToggleExpanded,
    required this.onItemTap,
  });

  final String title;
  final List<NavigationItem> items;
  final String? currentRoute;
  final bool isCollapsed;
  final Map<String, bool> expandedState;
  final void Function(String itemId) onToggleExpanded;
  final void Function(NavigationItem item) onItemTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCollapsed && title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom: AppSpacing.xs,
            ),
            child: Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ...items.map((item) {
          final isActive = currentRoute != null &&
              (item.route == currentRoute ||
                  (item.children ?? const []).any((child) => child.route == currentRoute));
          final isExpanded = expandedState[item.id] ?? item.initiallyExpanded;

          return SidebarItem(
            item: item,
            isActive: isActive,
            isExpanded: isExpanded,
            isCollapsed: isCollapsed,
            onTap: () => onItemTap(item),
            onExpand: () => onToggleExpanded(item.id),
            onItemTap: onItemTap,
            currentRoute: currentRoute,
          );
        }),
      ],
    );
  }
}
