import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';

/// Notification bell button widget.
class AppNotificationButton extends StatefulWidget {
  const AppNotificationButton({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
    this.onClearAll,
  });

  final List<Map<String, dynamic>> notifications;
  final Function(String id) onNotificationTap;
  final VoidCallback? onClearAll;

  @override
  State<AppNotificationButton> createState() => _AppNotificationButtonState();
}

class _AppNotificationButtonState extends State<AppNotificationButton> {
  late List<Map<String, dynamic>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(widget.notifications);
  }

  int get unreadCount => _notifications.where((n) => n['isRead'] == false).length;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (unreadCount > 0)
                        Badge(
                          label: Text(unreadCount.toString()),
                        ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                if (_notifications.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Center(
                      child: Text(
                        'No notifications',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          title: Text(
                            notification['title'] ?? 'Notification',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          subtitle: Text(
                            notification['message'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          onTap: () {
                            widget.onNotificationTap(notification['id']);
                            Navigator.pop(context);
                          },
                          trailing: !notification['isRead']
                              ? Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('View All'),
                      ),
                      if (unreadCount > 0)
                        TextButton(
                          onPressed: () {
                            widget.onClearAll?.call();
                            Navigator.pop(context);
                          },
                          child: const Text('Clear All'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      icon: Badge(
        label: unreadCount > 0 ? Text(unreadCount.toString()) : null,
        child: const Icon(Icons.notifications_rounded),
      ),
    );
  }
}
