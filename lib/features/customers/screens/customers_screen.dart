import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../controllers/customer_controller.dart';
import '../models/customer.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_table.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late final CustomerController _controller;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CustomerController();
    _controller.addListener(() => setState(() {}));
    _controller.loadCustomers();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final customers = _controller.filteredCustomers;

    if (_controller.isLoading && _controller.customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: AppSpacing.md),
            Text('Loading customers...'),
          ],
        ),
      );
    }

    if (_controller.hasError && _controller.customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _controller.errorMessage ?? 'Unable to load customers',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: _controller.refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(isMobile),
        const SizedBox(height: AppSpacing.lg),

        // Search and Filter Bar
        _buildSearchAndFilter(),
        const SizedBox(height: AppSpacing.lg),

        // Customer List
        Expanded(
          child: customers.isEmpty
              ? _buildEmptyState()
              : (isMobile
                  ? _buildMobileList(customers)
                  : _buildDesktopTable(customers)),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customers',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Manage and view customer accounts',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        if (isMobile)
          FilledButton.icon(
            onPressed: _showAddCustomerDialog,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Add'),
          )
        else
          FilledButton.icon(
            onPressed: _showAddCustomerDialog,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('New Customer'),
          ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, code or phone...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: _controller.setQuery,
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 20),
              onPressed: () {
                _searchController.clear();
                _controller.setQuery('');
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopTable(List<Customer> customers) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CustomerTable(
          customers: customers,
          onView: (customer) => _showCustomerDetails(customer),
          onEdit: (customer) => _showEditCustomerDialog(customer),
          onDelete: (customer) => _showDeleteConfirm(customer),
          onToggleStatus: (customer) => _showToggleStatusConfirm(customer),
        ),
      ),
    );
  }

  Widget _buildMobileList(List<Customer> customers) {
    return ListView.separated(
      itemCount: customers.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final customer = customers[index];
        return CustomerCard(
          customer: customer,
          onView: () => _showCustomerDetails(customer),
          onEdit: () => _showEditCustomerDialog(customer),
          onDelete: () => _showDeleteConfirm(customer),
          onToggleStatus: () => _showToggleStatusConfirm(customer),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            _searchController.text.isEmpty ? 'No customers yet' : 'No results found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _searchController.text.isEmpty
                ? 'Create your first customer to get started'
                : 'Try changing your search keywords',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_searchController.text.isNotEmpty)
            OutlinedButton(
              onPressed: () {
                _searchController.clear();
                _controller.setQuery('');
              },
              child: const Text('Clear search'),
            ),
        ],
      ),
    );
  }

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (_) => _AddCustomerDialog(
        onSave: (name, phone, email) {
          final newCustomer = Customer(
            id: 'CUS-${DateTime.now().millisecondsSinceEpoch}',
            customerCode: 'CUS-${_controller.customers.length + 1}',
            name: name,
            type: CustomerType.business,
            phone: phone,
            mobile: phone,
            email: email,
            openingBalance: 0,
            balance: 0,
            creditLimit: 0,
            paymentTerms: 'Cash',
            status: CustomerStatus.active,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          _controller.addCustomer(newCustomer);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$name added successfully')),
          );
        },
      ),
    );
  }

  void _showEditCustomerDialog(Customer customer) {
    showDialog(
      context: context,
      builder: (_) => _EditCustomerDialog(
        customer: customer,
        onSave: (name, phone, email) {
          final updated = customer.copyWith(
            name: name,
            phone: phone,
            mobile: phone,
            email: email,
            updatedAt: DateTime.now(),
          );
          _controller.updateCustomer(updated);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Customer updated')),
          );
        },
      ),
    );
  }

  void _showCustomerDetails(Customer customer) {
    showDialog(
      context: context,
      builder: (_) => _CustomerDetailsDialog(customer: customer),
    );
  }

  void _showDeleteConfirm(Customer customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Customer?'),
        content: Text('Remove ${customer.name} from your customer list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              _controller.deleteCustomer(customer.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Customer deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showToggleStatusConfirm(Customer customer) {
    final newStatus = customer.status == CustomerStatus.active
        ? CustomerStatus.inactive
        : CustomerStatus.active;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Status?'),
        content: Text('Change ${customer.name} to $newStatus?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _controller.toggleCustomerStatus(customer);
              Navigator.pop(context);
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}

// Add Customer Dialog
class _AddCustomerDialog extends StatefulWidget {
  const _AddCustomerDialog({required this.onSave});

  final Function(String name, String phone, String email) onSave;

  @override
  State<_AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<_AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate save with mock delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        widget.onSave(
          _nameController.text,
          _phoneController.text,
          _emailController.text,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Customer'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name *',
                    hintText: 'e.g. Ahmed Trading Company',
                    prefixIcon: Icon(Icons.business_rounded),
                  ),
                  validator: (v) => v?.trim().isEmpty ?? true
                      ? 'Customer name is required'
                      : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone *',
                    hintText: 'e.g. 01012345678',
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                  validator: (v) => v?.trim().isEmpty ?? true
                      ? 'Phone is required'
                      : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'e.g. contact@company.com',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  validator: (v) {
                    if ((v?.trim() ?? '').isEmpty) return null;
                    if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(v!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '* Required fields',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save Customer'),
        ),
      ],
    );
  }
}

// Edit Customer Dialog
class _EditCustomerDialog extends StatefulWidget {
  const _EditCustomerDialog({
    required this.customer,
    required this.onSave,
  });

  final Customer customer;
  final Function(String name, String phone, String email) onSave;

  @override
  State<_EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<_EditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _emailController = TextEditingController(text: widget.customer.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        widget.onSave(
          _nameController.text,
          _phoneController.text,
          _emailController.text,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Customer'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name *',
                    prefixIcon: Icon(Icons.business_rounded),
                  ),
                  validator: (v) => v?.trim().isEmpty ?? true
                      ? 'Customer name is required'
                      : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone *',
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                  validator: (v) => v?.trim().isEmpty ?? true
                      ? 'Phone is required'
                      : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  validator: (v) {
                    if ((v?.trim() ?? '').isEmpty) return null;
                    if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(v!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save Changes'),
        ),
      ],
    );
  }
}

// Customer Details Dialog
class _CustomerDetailsDialog extends StatelessWidget {
  const _CustomerDetailsDialog({required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(customer.name),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow('Code', customer.customerCode),
              const Divider(),
              _DetailRow('Phone', customer.phone),
              const Divider(),
              _DetailRow('Email', customer.email),
              const Divider(),
              _DetailRow('Type', customer.type),
              const Divider(),
              _DetailRow('Status', customer.status),
              const Divider(),
              _DetailRow('Balance', 'EGP ${customer.balance.toStringAsFixed(0)}'),
              const Divider(),
              _DetailRow('Credit Limit', 'EGP ${customer.creditLimit.toStringAsFixed(0)}'),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
