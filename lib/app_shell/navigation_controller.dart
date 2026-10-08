import 'package:flutter/material.dart';

/// Controller for managing app shell and navigation UI state.
class NavigationController extends ChangeNotifier {
  bool _isSidebarCollapsed = false;
  bool _isDrawerOpen = false;
  String? _currentRoute;
  int _selectedBottomNavIndex = 0;

  bool get isSidebarCollapsed => _isSidebarCollapsed;
  bool get isDrawerOpen => _isDrawerOpen;
  String? get currentRoute => _currentRoute;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;

  /// Toggle sidebar collapsed state
  void toggleSidebarCollapsed() {
    _isSidebarCollapsed = !_isSidebarCollapsed;
    notifyListeners();
  }

  /// Set sidebar collapsed state
  void setSidebarCollapsed(bool collapsed) {
    if (_isSidebarCollapsed != collapsed) {
      _isSidebarCollapsed = collapsed;
      notifyListeners();
    }
  }

  /// Toggle drawer open state
  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }

  /// Set drawer open state
  void setDrawerOpen(bool open) {
    if (_isDrawerOpen != open) {
      _isDrawerOpen = open;
      notifyListeners();
    }
  }

  /// Update current route
  void updateCurrentRoute(String? route) {
    if (_currentRoute != route) {
      _currentRoute = route;
      notifyListeners();
    }
  }

  /// Update selected bottom nav index
  void updateSelectedBottomNavIndex(int index) {
    if (_selectedBottomNavIndex != index) {
      _selectedBottomNavIndex = index;
      notifyListeners();
    }
  }

  /// Close drawer if open
  void closeDrawer() {
    if (_isDrawerOpen) {
      _isDrawerOpen = false;
      notifyListeners();
    }
  }

  /// Reset to default state
  void reset() {
    _isSidebarCollapsed = false;
    _isDrawerOpen = false;
    _currentRoute = null;
    _selectedBottomNavIndex = 0;
    notifyListeners();
  }
}
