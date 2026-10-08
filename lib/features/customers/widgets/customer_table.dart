import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/shared/status_badge.dart';
import '../models/customer.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({
    super.key,
    required this.customers,
    this.onView,
    this.onEdit,
    this.onToggleStatus,
    this.onDelete,
  });

  final List<Customer> customers;
  final Function(Customer)? onView;
  final Function(Customer)? onEdit;
  final Function(Customer)? onToggleStatus;
  final Function(Customer)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                headingRowColor: WidgetStateProperty.resolveWith(
                  (states) => AppColors.surfaceContainer,
                ),
                columns: const [
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Balance')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: customers.map((customer) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.primaryContainer,
                              child: Text(
                                customer.initials,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(
                              child: Text(
                                customer.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(customer.customerCode)),
                      DataCell(Text(customer.phone)),
                      DataCell(Text(customer.email)),
                      DataCell(Text(customer.type)),
                      DataCell(Text('EGP ${customer.balance.toStringAsFixed(0)}')),
                      DataCell(
                        AppStatusBadge(
                          label: customer.status,
                          backgroundColor: _statusBg(customer.status),
                          textColor: _statusText(customer.status),
                          icon: _statusIcon(customer.status),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () => onView?.call(customer),
                              child: const Text('View'),
                            ),
                            TextButton(
                              onPressed: () => onEdit?.call(customer),
                              child: const Text('Edit'),
                            ),
                            IconButton(
                              onPressed: () => onDelete?.call(customer),
                              icon: const Icon(Icons.delete_outline_rounded),
                              color: AppColors.error,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

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
}
