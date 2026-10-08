import 'package:flutter/material.dart';

import 'navigation_item.dart';

class AppNavigationConfig {
  AppNavigationConfig._();

  static List<NavigationItem> getNavigationItems() {
    return [
      NavigationItem(
        id: 'dashboard',
        title: 'Dashboard',
        icon: Icons.dashboard_rounded,
        route: '/dashboard',
        section: 'MAIN',
      ),
      NavigationItem(
        id: 'sales',
        title: 'Sales',
        icon: Icons.shopping_cart_rounded,
        route: '/sales',
        section: 'SALES',
        badge: '3',
        initiallyExpanded: true,
        children: [
          NavigationItem(
            id: 'sales-returns',
            title: 'Sales Returns',
            icon: Icons.undo_rounded,
            route: '/sales/returns',
            section: 'SALES',
            badge: '3',
          ),
          NavigationItem(
            id: 'customers',
            title: 'Customers',
            icon: Icons.people_rounded,
            route: '/customers',
            section: 'SALES',
          ),
        ],
      ),
      NavigationItem(
        id: 'purchases',
        title: 'Purchases',
        icon: Icons.shopping_bag_rounded,
        route: '/purchases',
        section: 'PURCHASES',
        badge: '2',
        children: [
          NavigationItem(
            id: 'purchase-returns',
            title: 'Purchase Returns',
            icon: Icons.undo_rounded,
            route: '/purchases/returns',
            section: 'PURCHASES',
          ),
          NavigationItem(
            id: 'suppliers',
            title: 'Suppliers',
            icon: Icons.business_rounded,
            route: '/suppliers',
            section: 'PURCHASES',
          ),
        ],
      ),
      NavigationItem(
        id: 'inventory',
        title: 'Inventory',
        icon: Icons.inventory_2_rounded,
        route: '/inventory',
        section: 'INVENTORY',
        badge: '7',
        children: [
          NavigationItem(
            id: 'inventory-products',
            title: 'Products',
            icon: Icons.inventory_2_rounded,
            route: '/inventory/products',
            section: 'INVENTORY',
          ),
          NavigationItem(
            id: 'inventory-categories',
            title: 'Categories',
            icon: Icons.category_rounded,
            route: '/categories',
            section: 'INVENTORY',
          ),
          NavigationItem(
            id: 'inventory-warehouses',
            title: 'Warehouses',
            icon: Icons.warehouse_rounded,
            route: '/warehouses',
            section: 'INVENTORY',
          ),
          NavigationItem(
            id: 'inventory-transfers',
            title: 'Stock Transfers',
            icon: Icons.compare_arrows_rounded,
            route: '/inventory/transfers',
            section: 'INVENTORY',
          ),
        ],
      ),
      NavigationItem(
        id: 'accounting',
        title: 'Accounting',
        icon: Icons.calculate_rounded,
        route: '/accounting',
        section: 'ACCOUNTING',
        children: [
          NavigationItem(
            id: 'accounting-coa',
            title: 'Chart of Accounts',
            icon: Icons.list_rounded,
            route: '/accounting/chart-of-accounts',
            section: 'ACCOUNTING',
          ),
          NavigationItem(
            id: 'accounting-entries',
            title: 'Journal Entries',
            icon: Icons.assignment_rounded,
            route: '/accounting/journal-entries',
            section: 'ACCOUNTING',
          ),
          NavigationItem(
            id: 'accounting-ledger',
            title: 'General Ledger',
            icon: Icons.library_books_rounded,
            route: '/accounting/general-ledger',
            section: 'ACCOUNTING',
          ),
          NavigationItem(
            id: 'accounting-trial',
            title: 'Trial Balance',
            icon: Icons.balance_rounded,
            route: '/accounting/trial-balance',
            section: 'ACCOUNTING',
          ),
        ],
      ),
      NavigationItem(
        id: 'reports',
        title: 'Reports',
        icon: Icons.assessment_rounded,
        route: '/reports',
        section: 'REPORTS',
        children: [
          NavigationItem(
            id: 'reports-sales',
            title: 'Sales Reports',
            icon: Icons.trending_up_rounded,
            route: '/reports/sales',
            section: 'REPORTS',
          ),
          NavigationItem(
            id: 'reports-purchases',
            title: 'Purchase Reports',
            icon: Icons.trending_down_rounded,
            route: '/reports/purchases',
            section: 'REPORTS',
          ),
          NavigationItem(
            id: 'reports-inventory',
            title: 'Inventory Reports',
            icon: Icons.inventory_rounded,
            route: '/reports/inventory',
            section: 'REPORTS',
          ),
          NavigationItem(
            id: 'reports-financial',
            title: 'Financial Reports',
            icon: Icons.payments_rounded,
            route: '/reports/financial',
            section: 'REPORTS',
          ),
        ],
      ),
      NavigationItem(
        id: 'users',
        title: 'Users',
        icon: Icons.group_rounded,
        route: '/users',
        section: 'SYSTEM',
      ),
      NavigationItem(
        id: 'company',
        title: 'Company',
        icon: Icons.business_center_rounded,
        route: '/company',
        section: 'SYSTEM',
      ),
      NavigationItem(
        id: 'settings',
        title: 'Settings',
        icon: Icons.settings_rounded,
        route: '/settings',
        section: 'SYSTEM',
      ),
      NavigationItem(
        id: 'profile',
        title: 'Profile',
        icon: Icons.person_rounded,
        route: '/profile',
        section: 'PROFILE',
      ),
    ];
  }

  /// Get user mock data
  static Map<String, dynamic> getCurrentUser() {
    return {
      'id': '1',
      'name': 'Ahmed Elshrif',
      'email': 'ahmed@zodicrp.com',
      'role': 'Administrator',
      'avatar': null,
      'phone': '+20 123 456 7890',
    };
  }

  /// Get company mock data
  static List<Map<String, dynamic>> getCompanies() {
    return [
      {
        'id': '1',
        'name': 'ZodicERP Ltd',
        'code': 'ZRP',
        'logo': null,
      },
      {
        'id': '2',
        'name': 'Tech Solutions Inc',
        'code': 'TSI',
        'logo': null,
      },
      {
        'id': '3',
        'name': 'Global Ventures',
        'code': 'GV',
        'logo': null,
      },
    ];
  }

  /// Get mock notifications
  static List<Map<String, dynamic>> getNotifications() {
    return [
      {
        'id': '1',
        'title': 'New Sales Invoice',
        'message': 'Invoice INV-2024-001 has been created',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'Low Stock Alert',
        'message': 'Product SKU-001 is running low on stock',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'isRead': false,
      },
      {
        'id': '3',
        'title': 'Payment Received',
        'message': 'Payment of \$1,500.00 received from ACME Corp',
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
        'isRead': true,
      },
      {
        'id': '4',
        'title': 'Report Generated',
        'message': 'Monthly sales report is ready for download',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'isRead': true,
      },
    ];
  }
}
