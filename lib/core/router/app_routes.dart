class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Authenticated routes
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Sales routes
  static const String sales = '/sales';
  static const String salesInvoices = '/sales/invoices';
  static const String salesReturns = '/sales/returns';
  static const String salesCustomers = '/sales/customers';
  static const String salesPayments = '/sales/payments';

  // Purchase routes
  static const String purchases = '/purchases';
  static const String purchasesInvoices = '/purchases/invoices';
  static const String purchasesReturns = '/purchases/returns';
  static const String purchasesSuppliers = '/purchases/suppliers';
  static const String purchasesPayments = '/purchases/payments';

  // Inventory routes
  static const String inventory = '/inventory';
  static const String inventoryProducts = '/inventory/products';
  static const String inventoryWarehouses = '/inventory/warehouses';
  static const String inventoryStock = '/inventory/stock';
  static const String inventoryTransfers = '/inventory/transfers';

  // Accounting routes
  static const String accounting = '/accounting';
  static const String accountingChartOfAccounts = '/accounting/chart-of-accounts';
  static const String accountingJournalEntries = '/accounting/journal-entries';
  static const String accountingGeneralLedger = '/accounting/general-ledger';
  static const String accountingTrialBalance = '/accounting/trial-balance';

  // Reports routes
  static const String reports = '/reports';
  static const String reportsSales = '/reports/sales';
  static const String reportsPurchases = '/reports/purchases';
  static const String reportsInventory = '/reports/inventory';
  static const String reportsFinancial = '/reports/financial';

  // Users routes
  static const String users = '/users';

  // Customers routes
  static const String customers = '/customers';
  static const String customersCreate = '/customers/create';
  static const String customerDetails = '/customers/details';
}
