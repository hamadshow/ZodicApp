import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../core/widgets/app_bar/app_bar.dart';
import '../core/widgets/app_bar/company_selector.dart';
import '../core/widgets/app_bar/notification_button.dart';
import '../core/widgets/app_bar/profile_button.dart';
import '../core/widgets/sidebar/sidebar.dart';
import 'navigation_config.dart';
import 'navigation_item.dart';

/// Main application shell for authenticated pages.
class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.currentRoute,
    this.onNavigate,
  });

  final Widget child;
  final String? currentRoute;
  final Function(NavigationItem)? onNavigate;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<NavigationItem> _navigationItems;
  late Map<String, dynamic> _currentUser;
  late List<Map<String, dynamic>> _companies;
  late Map<String, dynamic> _selectedCompany;
  late List<Map<String, dynamic>> _notifications;

  bool _isSidebarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _navigationItems = AppNavigationConfig.getNavigationItems();
    _currentUser = AppNavigationConfig.getCurrentUser();
    _companies = AppNavigationConfig.getCompanies();
    _selectedCompany = _companies.first;
    _notifications = AppNavigationConfig.getNotifications();
  }

  void _handleNavigation(NavigationItem item) {
    widget.onNavigate?.call(item);
    if (item.route != null) {
      if (item.route == '/login') {
        _handleLogout();
        return;
      }
      Navigator.of(context).pushNamed(item.route!);
    }
  }

  void _toggleSidebar() {
    setState(() => _isSidebarCollapsed = !_isSidebarCollapsed);
  }

  void _handleMenuPressed() {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    if (isMobile) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    }

    _toggleSidebar();
  }

  void _handleCompanyChanged(Map<String, dynamic> company) {
    setState(() => _selectedCompany = company);
  }

  void _handleNotificationTap(String id) {
    final index = _notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      setState(() {
        _notifications[index]['isRead'] = true;
      });
    }
  }

  void _handleClearAllNotifications() {
    setState(() {
      for (final notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppAppBar(
        onMenuPressed: _handleMenuPressed,
        title: 'ZodicERP',
        actions: [
          AppCompanySelector(
            companies: _companies,
            selectedCompany: _selectedCompany,
            onCompanyChanged: _handleCompanyChanged,
          ),
          AppNotificationButton(
            notifications: _notifications,
            onNotificationTap: _handleNotificationTap,
            onClearAll: _handleClearAllNotifications,
          ),
          AppProfileButton(
            user: _currentUser,
            onLogout: _handleLogout,
            onProfileTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
            onSettingsTap: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      drawer: isMobile
          ? Drawer(
              child: Sidebar(
                items: _navigationItems,
                currentRoute: widget.currentRoute,
                onItemTap: (item) {
                  Navigator.pop(context);
                  _handleNavigation(item);
                },
                isCollapsed: false,
                onCollapsedChanged: (_) {},
                user: _currentUser,
                onLogout: _handleLogout,
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              if (!isMobile)
                Sidebar(
                  items: _navigationItems,
                  currentRoute: widget.currentRoute,
                  onItemTap: _handleNavigation,
                  isCollapsed: _isSidebarCollapsed,
                  onCollapsedChanged: (collapsed) {
                    setState(() => _isSidebarCollapsed = collapsed);
                  },
                  user: _currentUser,
                  onLogout: _handleLogout,
                ),
              Expanded(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
                    child: widget.child,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
