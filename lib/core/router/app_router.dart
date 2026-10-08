import 'package:flutter/material.dart';

import '../../app_shell/app_shell.dart';
import '../../features/accounting/screens/accounting_screen.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/company/screens/company_screen.dart';
import '../../features/customers/screens/customers_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/inventory/screens/inventory_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/purchases/screens/purchases_screen.dart';
import '../../features/purchase_return/screens/purchase_returns_screen.dart';
import '../../features/reports/screens/reports_screen.dart';
import '../../features/sales/screens/sales_returns_screen.dart';
import '../../features/sales/screens/sales_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/suppliers/screens/suppliers_screen.dart';
import '../../features/users/screens/users_screen.dart';
import '../../features/warehouses/screens/warehouses_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final _authController = AuthController();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // =====================
      // AUTHENTICATION ROUTES
      // =====================
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(
            controller: _authController,
            onNavigateToForgotPassword: () {
              Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
            },
            onLoginSuccess: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.dashboard,
                (route) => false,
              );
            },
          ),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(
            controller: _authController,
            onBackToLogin: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            controller: _authController,
            onBackToLogin: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        );

      // =====================
      // AUTHENTICATED ROUTES (wrapped in AppShell)
      // =====================
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.dashboard,
            onNavigate: (item) {},
            child: const DashboardScreen(),
          ),
        );

      // =====================
      // SALES ROUTES
      // =====================
      case AppRoutes.sales:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.sales,
            onNavigate: (item) {},
            child: const SalesScreen(),
          ),
        );
      case AppRoutes.salesReturns:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.salesReturns,
            onNavigate: (item) {},
            child: const SalesReturnsScreen(),
          ),
        );

      // =====================
      // CUSTOMERS ROUTES
      // =====================
      case AppRoutes.customers:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.customers,
            onNavigate: (item) {},
            child: const CustomersScreen(),
          ),
        );
      case AppRoutes.customersCreate:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.customersCreate,
            onNavigate: (item) {},
            child: const CustomersScreen(),
          ),
        );
      case AppRoutes.customerDetails:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.customerDetails,
            onNavigate: (item) {},
            child: const CustomersScreen(),
          ),
        );

      // =====================
      // PURCHASES ROUTES
      // =====================
      case AppRoutes.purchases:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.purchases,
            onNavigate: (item) {},
            child: const PurchasesScreen(),
          ),
        );
      case AppRoutes.purchasesReturns:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.purchasesReturns,
            onNavigate: (item) {},
            child: const PurchaseReturnsScreen(),
          ),
        );

      // =====================
      // SUPPLIERS ROUTES
      // =====================
      case '/suppliers':
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: '/suppliers',
            onNavigate: (item) {},
            child: const SuppliersScreen(),
          ),
        );

      // =====================
      // INVENTORY ROUTES
      // =====================
      case AppRoutes.inventory:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.inventory,
            onNavigate: (item) {},
            child: const InventoryScreen(),
          ),
        );
      case AppRoutes.inventoryProducts:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.inventoryProducts,
            onNavigate: (item) {},
            child: const InventoryScreen(),
          ),
        );
      case AppRoutes.inventoryWarehouses:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.inventoryWarehouses,
            onNavigate: (item) {},
            child: const WarehousesScreen(),
          ),
        );

      // =====================
      // ACCOUNTING ROUTES
      // =====================
      case AppRoutes.accounting:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.accounting,
            onNavigate: (item) {},
            child: const AccountingScreen(),
          ),
        );

      // =====================
      // REPORTS ROUTES
      // =====================
      case AppRoutes.reports:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.reports,
            onNavigate: (item) {},
            child: const ReportsScreen(),
          ),
        );

      // =====================
      // USERS ROUTES
      // =====================
      case AppRoutes.users:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.users,
            onNavigate: (item) {},
            child: const UsersScreen(),
          ),
        );

      // =====================
      // COMPANY ROUTES
      // =====================
      case '/company':
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: '/company',
            onNavigate: (item) {},
            child: const CompanyScreen(),
          ),
        );

      // =====================
      // SETTINGS ROUTES
      // =====================
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.settings,
            onNavigate: (item) {},
            child: const SettingsScreen(),
          ),
        );

      // =====================
      // PROFILE ROUTES
      // =====================
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => AppShell(
            currentRoute: AppRoutes.profile,
            onNavigate: (item) {},
            child: const ProfileScreen(),
          ),
        );

      // =====================
      // DEFAULT
      // =====================
      default:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            controller: _authController,
            onNavigateToForgotPassword: () {},
            onLoginSuccess: () {},
          ),
        );
    }
  }
}
