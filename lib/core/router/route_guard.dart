/// Route guard for handling authentication and authorization.
class RouteGuard {
  RouteGuard._();

  /// Mock current user session
  static bool get isAuthenticated => _mockUser != null;

  static Map<String, dynamic>? _mockUser;

  /// Mock user data
  static Map<String, dynamic> get currentUser =>
      _mockUser ?? _getDefaultMockUser();

  /// Permissions for current user (mock data)
  static Set<String> get userPermissions => _currentPermissions;

  static final Set<String> _currentPermissions = {
    'dashboard.view',
    'sales.view',
    'sales.create',
    'sales.edit',
    'sales.delete',
    'sales-returns.view',
    'customers.view',
    'customers.create',
    'purchases.view',
    'purchases.create',
    'purchases.edit',
    'purchases-returns.view',
    'suppliers.view',
    'suppliers.create',
    'products.view',
    'products.create',
    'products.edit',
    'inventory.view',
    'inventory.create',
    'warehouses.view',
    'accounting.view',
    'accounting.create',
    'reports.view',
    'users.view',
    'users.create',
    'users.edit',
    'company.view',
    'company.edit',
    'settings.view',
    'profile.view',
    'profile.edit',
  };

  /// Initialize mock user session
  static void mockLogin(Map<String, dynamic> user) {
    _mockUser = user;
  }

  /// Logout and clear session
  static void logout() {
    _mockUser = null;
  }

  /// Check if user has permission
  static bool hasPermission(String permission) {
    return userPermissions.contains(permission);
  }

  /// Get default mock user
  static Map<String, dynamic> _getDefaultMockUser() {
    return {
      'id': '1',
      'name': 'Ahmed Elshrif',
      'email': 'ahmed@zodicerp.com',
      'role': 'Administrator',
      'avatar': null,
      'phone': '+20 123 456 7890',
      'department': 'Management',
      'joinDate': '2024-01-01',
    };
  }

  /// Initialize with mock user on app start
  static void initializeMockSession() {
    _mockUser = _getDefaultMockUser();
  }
}
