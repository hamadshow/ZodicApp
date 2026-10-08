import 'package:flutter/material.dart';

/// Navigation item model for sidebar/drawer navigation.
class NavigationItem {
  final String id;
  final String title;
  final IconData icon;
  final String? route;
  final List<NavigationItem>? children;
  final bool isHeader;
  final String? section;
  final String? permission;
  final String? badge;
  final bool enabled;
  final bool initiallyExpanded;
  final String? tooltip;

  NavigationItem({
    required this.id,
    required this.title,
    required this.icon,
    this.route,
    this.children,
    this.isHeader = false,
    this.section,
    this.permission,
    this.badge,
    this.enabled = true,
    this.initiallyExpanded = false,
    this.tooltip,
  });

  bool get hasChildren => children != null && children!.isNotEmpty;
  bool get isExpandable => hasChildren;
  bool get hasBadge => badge != null && badge!.trim().isNotEmpty;
}
