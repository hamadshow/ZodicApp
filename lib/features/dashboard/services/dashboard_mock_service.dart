import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/dashboard_models.dart';

class DashboardMockService {
  Future<DashboardData> getDashboardData({String period = 'This Month'}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return DashboardData(
      metrics: [
        DashboardMetric(
          title: 'Revenue',
          value: '\$84.6K',
          change: '+12.4%',
          icon: Icons.trending_up_rounded,
          color: AppColors.success,
          positive: true,
        ),
        DashboardMetric(
          title: 'Orders',
          value: '1,284',
          change: '+8.2%',
          icon: Icons.receipt_long_rounded,
          color: AppColors.primary,
          positive: true,
        ),
        DashboardMetric(
          title: 'Expenses',
          value: '\$32.1K',
          change: '-4.6%',
          icon: Icons.account_balance_wallet_rounded,
          color: AppColors.warning,
          positive: false,
        ),
        DashboardMetric(
          title: 'Profit',
          value: '\$52.5K',
          change: '+15.1%',
          icon: Icons.pie_chart_rounded,
          color: AppColors.info,
          positive: true,
        ),
      ],
      salesTrend: const [
        DashboardTrendPoint(label: 'Jan', value: 28),
        DashboardTrendPoint(label: 'Feb', value: 36),
        DashboardTrendPoint(label: 'Mar', value: 42),
        DashboardTrendPoint(label: 'Apr', value: 33),
        DashboardTrendPoint(label: 'May', value: 48),
        DashboardTrendPoint(label: 'Jun', value: 62),
      ],
      transactions: const [
        DashboardTransaction(
          id: 'INV-1042',
          customer: 'Apex Retail',
          amount: '\$4,250.00',
          status: 'Paid',
          time: '12 mins ago',
          type: 'Invoice',
        ),
        DashboardTransaction(
          id: 'PO-8821',
          customer: 'Northwind Foods',
          amount: '\$2,900.00',
          status: 'Pending',
          time: '1 hour ago',
          type: 'Purchase',
        ),
        DashboardTransaction(
          id: 'SO-7745',
          customer: 'Modern Office',
          amount: '\$1,780.00',
          status: 'Completed',
          time: '3 hours ago',
          type: 'Sale',
        ),
      ],
      topProducts: const [
        DashboardProduct(name: 'Premium Laptop', sales: '142 sold', revenue: '\$34.2K', stock: '92 left'),
        DashboardProduct(name: 'Office Chair', sales: '96 sold', revenue: '\$18.4K', stock: '210 left'),
        DashboardProduct(name: 'Wireless Mouse', sales: '204 sold', revenue: '\$9.8K', stock: '518 left'),
      ],
      lowStockItems: const [
        DashboardInventoryAlert(name: 'USB-C Dock', stock: '12', minStock: '25', unit: 'units'),
        DashboardInventoryAlert(name: 'Printer Paper', stock: '8', minStock: '30', unit: 'packs'),
        DashboardInventoryAlert(name: 'Monitor Cable', stock: '14', minStock: '40', unit: 'units'),
      ],
      quickActions: const [
        DashboardQuickAction(
          title: 'New Sale',
          subtitle: 'Create a sale',
          icon: Icons.sell_rounded,
          color: AppColors.primary,
        ),
        DashboardQuickAction(
          title: 'Receive Stock',
          subtitle: 'Add inventory',
          icon: Icons.inventory_2_rounded,
          color: AppColors.success,
        ),
        DashboardQuickAction(
          title: 'Add Customer',
          subtitle: 'Create account',
          icon: Icons.people_alt_rounded,
          color: AppColors.warning,
        ),
      ],
    );
  }
}
