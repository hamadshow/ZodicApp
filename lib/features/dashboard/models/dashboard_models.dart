import 'package:flutter/material.dart';

class DashboardMetric {
  const DashboardMetric({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
    this.positive = true,
  });

  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final bool positive;
}

class DashboardTrendPoint {
  const DashboardTrendPoint({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;
}

class DashboardTransaction {
  const DashboardTransaction({
    required this.id,
    required this.customer,
    required this.amount,
    required this.status,
    required this.time,
    required this.type,
  });

  final String id;
  final String customer;
  final String amount;
  final String status;
  final String time;
  final String type;
}

class DashboardProduct {
  const DashboardProduct({
    required this.name,
    required this.sales,
    required this.revenue,
    required this.stock,
  });

  final String name;
  final String sales;
  final String revenue;
  final String stock;
}

class DashboardInventoryAlert {
  const DashboardInventoryAlert({
    required this.name,
    required this.stock,
    required this.minStock,
    required this.unit,
  });

  final String name;
  final String stock;
  final String minStock;
  final String unit;
}

class DashboardQuickAction {
  const DashboardQuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class DashboardData {
  const DashboardData({
    required this.metrics,
    required this.salesTrend,
    required this.transactions,
    required this.topProducts,
    required this.lowStockItems,
    required this.quickActions,
  });

  final List<DashboardMetric> metrics;
  final List<DashboardTrendPoint> salesTrend;
  final List<DashboardTransaction> transactions;
  final List<DashboardProduct> topProducts;
  final List<DashboardInventoryAlert> lowStockItems;
  final List<DashboardQuickAction> quickActions;
}
