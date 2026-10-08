import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/cards/dashboard_card.dart';
import '../../../core/widgets/cards/statistics_card.dart';
import '../../../core/widgets/empty/empty_page.dart';
import '../../../core/widgets/error/error_page.dart';
import '../../../core/widgets/loading/loading_indicator.dart';
import '../../../core/widgets/shared/status_badge.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_models.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.controller});

  final DashboardController? controller;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DashboardController();
    _controller.loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        if (_controller.isLoading && _controller.data == null) {
          return const AppLoadingPage(message: 'Loading dashboard...');
        }

        if (_controller.hasError && _controller.data == null) {
          return AppErrorState(
            title: 'Dashboard unavailable',
            message: _controller.errorMessage ?? 'We could not load the dashboard.',
            onRetry: () => _controller.refresh(),
          );
        }

        final data = _controller.data;
        if (data == null) {
          return const AppEmptyState(
            title: 'No dashboard data',
            message: 'There is no data to display yet.',
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, data),
                const SizedBox(height: AppSpacing.xl),
                _buildPeriodSelector(context),
                const SizedBox(height: AppSpacing.xl),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth < 600
                        ? 1
                        : constraints.maxWidth < 900
                            ? 2
                            : 4;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: AppSpacing.lg,
                        crossAxisSpacing: AppSpacing.lg,
                        childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.5,
                      ),
                      itemCount: data.metrics.length,
                      itemBuilder: (context, index) {
                        final metric = data.metrics[index];
                        return AppStatCard(
                          title: metric.title,
                          value: metric.value,
                          subtitle: '${metric.change} vs last period',
                          icon: metric.icon,
                          valueColor: metric.color,
                          backgroundColor: metric.color.withValues(alpha: 0.12),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    return isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: _buildTrendCard(context, data.salesTrend)),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(child: _buildQuickActions(context, data.quickActions)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTrendCard(context, data.salesTrend),
                              const SizedBox(height: AppSpacing.lg),
                              _buildQuickActions(context, data.quickActions),
                            ],
                          );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    return isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: _buildTransactions(context, data.transactions)),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(child: _buildStockAlerts(context, data.lowStockItems)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTransactions(context, data.transactions),
                              const SizedBox(height: AppSpacing.lg),
                              _buildStockAlerts(context, data.lowStockItems),
                            ],
                          );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                _buildTopProducts(context, data.topProducts),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, DashboardData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Welcome back, Admin',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: () => _controller.refresh(),
          icon: _controller.isLoading
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh_rounded),
          label: const Text('Refresh'),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    const periods = ['This Month', 'Quarterly', 'Yearly'];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: periods.map((period) {
        final active = _controller.selectedPeriod == period;
        return GestureDetector(
          onTap: () => _controller.loadDashboard(period: period),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: active ? AppColors.primaryContainer : AppColors.surface,
              border: Border.all(
                color: active ? AppColors.primary : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              period,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: active ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrendCard(BuildContext context, List<DashboardTrendPoint> trend) {
    final maxValue = trend.map((point) => point.value).reduce((a, b) => a > b ? a : b);

    return AppDashboardCard(
      title: 'Sales Trend',
      trailing: AppStatusBadge(
        label: '+18.2%',
        backgroundColor: AppColors.successContainer,
        textColor: AppColors.success,
      ),
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: trend.map((point) {
            final heightFactor = (point.value / maxValue) * 100;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: heightFactor.clamp(20, 100).toDouble(),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      point.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, List<DashboardQuickAction> actions) {
    return AppDashboardCard(
      title: 'Quick Actions',
      child: Column(
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: action.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(action.icon, color: action.color),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          action.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          action.subtitle,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactions(BuildContext context, List<DashboardTransaction> transactions) {
    return AppDashboardCard(
      title: 'Recent Transactions',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            transaction.customer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 88),
                          child: AppStatusBadge(
                            label: transaction.status,
                            backgroundColor: transaction.status == 'Paid'
                                ? AppColors.successContainer
                                : transaction.status == 'Pending'
                                    ? AppColors.warningContainer
                                    : AppColors.primaryContainer,
                            textColor: transaction.status == 'Paid'
                                ? AppColors.success
                                : transaction.status == 'Pending'
                                    ? AppColors.warning
                                    : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Text(
                          transaction.type,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text('•', style: TextStyle(color: AppColors.textMuted)),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          transaction.time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              SizedBox(
                width: 74,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    transaction.amount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopProducts(BuildContext context, List<DashboardProduct> products) {
    return AppDashboardCard(
      title: 'Top Products',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final product = products[index];
          return Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 42,
                child: Text(
                  product.sales,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 56,
                child: Text(
                  product.revenue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 44,
                child: Text(
                  product.stock,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStockAlerts(BuildContext context, List<DashboardInventoryAlert> alerts) {
    return AppDashboardCard(
      title: 'Low Stock',
      child: Column(
        children: alerts.map((alert) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '${alert.stock} / ${alert.minStock} ${alert.unit}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 70),
                  child: AppStatusBadge(
                    label: 'Low',
                    backgroundColor: AppColors.errorContainer,
                    textColor: AppColors.error,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
