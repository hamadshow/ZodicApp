import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';
import '../../../app_shell/navigation_item.dart';
import 'sidebar_footer.dart';
import 'sidebar_group.dart';
import 'sidebar_header.dart';
import 'sidebar_user.dart';

/// Main sidebar navigation widget.
class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.items,
    required this.currentRoute,
    required this.onItemTap,
    required this.isCollapsed,
    required this.onCollapsedChanged,
    this.user,
    this.onLogout,
    this.onProfileTap,
    this.onSettingsTap,
  });

  final List<NavigationItem> items;
  final String? currentRoute;
  final Function(NavigationItem) onItemTap;
  final bool isCollapsed;
  final Function(bool) onCollapsedChanged;
  final Map<String, dynamic>? user;
  final VoidCallback? onLogout;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late Map<String, bool> _expandedGroups;

  @override
  void initState() {
    super.initState();
    _expandedGroups = {
      for (final item in widget.items) item.id: item.initiallyExpanded,
    };
  }

  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _expandedGroups = {
        for (final item in widget.items) item.id: _expandedGroups[item.id] ?? item.initiallyExpanded,
      };
    }
  }

  void _toggleExpanded(String itemId) {
    setState(() {
      _expandedGroups[itemId] = !(_expandedGroups[itemId] ?? false);
    });
  }

  List<String> get _sections {
    final sections = <String>{};
    for (final item in widget.items) {
      if (item.section != null && item.section!.trim().isNotEmpty) {
        sections.add(item.section!);
      }
    }
    return sections.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = _sections;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOutCubic,
      width: widget.isCollapsed ? 88 : 282,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.18),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we should show the collapsed or expanded UI based on actual available width.
          // This prevents layout errors (negative constraints) during animation when width is small
          // but isCollapsed is already false. A threshold of 160px ensures all Row children fit.
          final bool effectivelyCollapsed = constraints.maxWidth < 160;

          return Column(
            children: [
              SidebarHeader(
                isCollapsed: effectivelyCollapsed,
                onToggleCollapse: () => widget.onCollapsedChanged(!widget.isCollapsed),
              ),
              const Divider(height: 1),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Column(
                      children: [
                        for (final section in sections)
                          SidebarGroup(
                            title: section,
                            items: widget.items
                                .where((item) => item.section == section)
                                .toList(),
                            currentRoute: widget.currentRoute,
                            isCollapsed: effectivelyCollapsed,
                            expandedState: _expandedGroups,
                            onToggleExpanded: _toggleExpanded,
                            onItemTap: widget.onItemTap,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              SidebarUser(
                user: widget.user,
                isCollapsed: effectivelyCollapsed,
                onTap: widget.onProfileTap,
              ),
              SidebarFooter(
                isCollapsed: effectivelyCollapsed,
                onProfileTap: widget.onProfileTap,
                onSettingsTap: widget.onSettingsTap,
                onLogout: widget.onLogout,
                onToggleCollapse: () => widget.onCollapsedChanged(!widget.isCollapsed),
              ),
            ],
          );
        },
      ),
    );
  }
}
