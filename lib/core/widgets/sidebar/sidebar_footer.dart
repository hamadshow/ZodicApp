import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';

class SidebarFooter extends StatelessWidget {
  const SidebarFooter({
    super.key,
    required this.isCollapsed,
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onLogout,
    required this.onToggleCollapse,
  });

  final bool isCollapsed;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogout;
  final VoidCallback onToggleCollapse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
      child: Column(
        children: [
          if (!isCollapsed) ...[
            _FooterAction(
              icon: Icons.person_rounded,
              label: 'Profile',
              color: AppColors.textPrimary,
              onTap: onProfileTap,
            ),
            const SizedBox(height: AppSpacing.xs),
            _FooterAction(
              icon: Icons.settings_rounded,
              label: 'Settings',
              color: AppColors.textPrimary,
              onTap: onSettingsTap,
            ),
            const SizedBox(height: AppSpacing.xs),
            _FooterAction(
              icon: Icons.logout_rounded,
              label: 'Logout',
              color: AppColors.error,
              onTap: onLogout,
            ),
          ] else ...[
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _FooterIconButton(icon: Icons.person_rounded, onTap: onProfileTap),
                _FooterIconButton(icon: Icons.settings_rounded, onTap: onSettingsTap),
                _FooterIconButton(icon: Icons.logout_rounded, onTap: onLogout, color: AppColors.error),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Divider(color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onToggleCollapse,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_right_rounded
                    : Icons.chevron_left_rounded,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterAction extends StatelessWidget {
  const _FooterAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterIconButton extends StatelessWidget {
  const _FooterIconButton({
    required this.icon,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
