import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../shared/avatar.dart';

/// User profile menu button.
class AppProfileButton extends StatelessWidget {
  const AppProfileButton({
    super.key,
    required this.user,
    required this.onLogout,
    this.onProfileTap,
    this.onSettingsTap,
  });

  final Map<String, dynamic> user;
  final VoidCallback onLogout;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      AppAvatar(
                        name: user['name'] ?? 'User',
                        size: 48,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'] ?? 'Unknown User',
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user['email'] ?? 'user@example.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user['role'] ?? 'User',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                PopupMenuItem<String>(
                  value: 'profile',
                  onTap: () => onProfileTap?.call(),
                  child: const Row(
                    children: [
                      Icon(Icons.person_outline_rounded, size: 20),
                      SizedBox(width: AppSpacing.md),
                      Text('My Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  onTap: () => onSettingsTap?.call(),
                  child: const Row(
                    children: [
                      Icon(Icons.settings_outlined, size: 20),
                      SizedBox(width: AppSpacing.md),
                      Text('Settings'),
                    ],
                  ),
                ),
                const Divider(height: 0),
                PopupMenuItem<String>(
                  value: 'logout',
                  onTap: onLogout,
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded, size: 20, color: AppColors.error),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        'Logout',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: AppAvatar(
          name: user['name'] ?? 'User',
          size: 40,
        ),
      ),
    );
  }
}
