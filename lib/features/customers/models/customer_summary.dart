class CustomerSummary {
  const CustomerSummary({
    required this.totalCustomers,
    required this.activeCustomers,
    required this.inactiveCustomers,
    required this.outstandingBalance,
  });

  final int totalCustomers;
  final int activeCustomers;
  final int inactiveCustomers;
  final double outstandingBalance;
}
