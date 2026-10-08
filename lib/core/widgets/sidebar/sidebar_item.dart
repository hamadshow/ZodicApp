import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_radius.dart';
import '../../constants/app_spacing.dart';
import '../../../app_shell/navigation_item.dart';

/// Single navigation item widget for sidebar.
class SidebarItem extends StatelessWidget {
  const SidebarItem({
    super.key,
    required this.item,
    required this.isActive,
    required this.isExpanded,
    required this.isCollapsed,
    required this.onTap,
    required this.onExpand,
    required this.onItemTap,
    this.level = 0,
    this.currentRoute,
  });

  final NavigationItem item;
  final bool isActive;
  final bool isExpanded;
  final bool isCollapsed;
  final VoidCallback onTap;
  final VoidCallback onExpand;
  final void Function(NavigationItem) onItemTap;
  final int level;
  final String? currentRoute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChildren = item.hasChildren;
    final actualOnTap = onTap;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(
            horizontal: isCollapsed ? AppSpacing.xs : AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: isActive ? theme.colorScheme.primaryContainer : Colors.transparent,
            borderRadius: AppRadius.md,
            border: isActive
                ? Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.22), width: 1)
                : null,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // If this item has children, treat the tap as expand/collapse only.
              // Do not navigate when toggling expansion to avoid parent clicks
              // accidentally triggering child navigation.
              if (hasChildren) {
                onExpand();
              } else {
                actualOnTap();
              }
            },

            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isCollapsed ? AppSpacing.sm : AppSpacing.md,
                vertical: isCollapsed ? AppSpacing.sm : AppSpacing.md,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Icon(
                      item.icon,
                      size: 18,
                      color: isActive ? theme.colorScheme.primary : AppColors.textSecondary,
                    ),
                  ),
                  if (!isCollapsed) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        item.title,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isActive ? theme.colorScheme.primary : AppColors.textPrimary,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  if (isCollapsed) ...[
                    const Spacer(),
                    if (hasChildren)
                      Icon(
                        isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        size: 14,
                        color: AppColors.textMuted,
                      )
                    else
                      const SizedBox(width: 14),
                  ] else ...[
                    if (hasChildren)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.sm),
                        child: Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    if (item.hasBadge && !isCollapsed)
                      Container(
                        margin: const EdgeInsets.only(left: AppSpacing.sm),
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.badge!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (hasChildren && isExpanded && !isCollapsed)
          Padding(
            padding: EdgeInsets.only(left: level == 0 ? AppSpacing.md : AppSpacing.lg),
            child: Column(
              children: item.children!.map((child) {
                final childIsActive = currentRoute != null && child.route == currentRoute;
                return SidebarItem(
                  item: child,
                  isActive: childIsActive,
                  isExpanded: false,
                  isCollapsed: false,
                  // For child items, invoke onItemTap with the child so child navigation is used
                  onTap: () => onItemTap(child),
                  onExpand: () {},
                  onItemTap: onItemTap,
                  level: level + 1,
                  currentRoute: currentRoute,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
