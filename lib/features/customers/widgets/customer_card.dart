import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/shared/status_badge.dart';
import '../models/customer.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.customer,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
  });

  final Customer customer;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleStatus;

  Color _statusBg(String status) {
    switch (status) {
      case CustomerStatus.active:
        return AppColors.successContainer;
      case CustomerStatus.inactive:
        return AppColors.warningContainer;
      case CustomerStatus.suspended:
        return AppColors.errorContainer;
      default:
        return AppColors.primaryContainer;
    }
  }

  Color _statusText(String status) {
    switch (status) {
      case CustomerStatus.active:
        return AppColors.success;
      case CustomerStatus.inactive:
        return AppColors.warning;
      case CustomerStatus.suspended:
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case CustomerStatus.active:
        return Icons.check_circle_rounded;
      case CustomerStatus.inactive:
        return Icons.pause_circle_rounded;
      case CustomerStatus.suspended:
        return Icons.block_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  customer.initials,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      customer.customerCode,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              AppStatusBadge(
                label: customer.status,
                backgroundColor: _statusBg(customer.status),
                textColor: _statusText(customer.status),
                icon: _statusIcon(customer.status),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _InfoRow(icon: Icons.phone_rounded, value: customer.phone),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(icon: Icons.email_rounded, value: customer.email),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(icon: Icons.currency_exchange_rounded, value: 'Balance: EGP ${customer.balance.toStringAsFixed(0)}'),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: onView,
                  icon: const Icon(Icons.visibility_rounded, size: 18),
                  label: const Text('View'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_rounded, size: 18),
                  label: const Text('Edit'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: onToggleStatus,
                  icon: const Icon(Icons.toggle_on_rounded, size: 18),
                  label: Text(customer.status == CustomerStatus.active ? 'Deactivate' : 'Activate'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
