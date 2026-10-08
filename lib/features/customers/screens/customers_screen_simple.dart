import 'package:flutter/material.dart';

import '../controllers/customer_controller.dart';

/// Temporary simple Customers screen for debugging
class CustomersScreenSimple extends StatefulWidget {
  const CustomersScreenSimple({super.key});

  @override
  State<CustomersScreenSimple> createState() => _CustomersScreenSimpleState();
}

class _CustomersScreenSimpleState extends State<CustomersScreenSimple> {
  late final CustomerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomerController();
    _controller.addListener(_onControllerChanged);
    _controller.loadCustomers();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Customers Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${_controller.isLoading ? '⏳ Loading' : '✓ Loaded'}'),
                  Text('Customer Count: ${_controller.customers.length}'),
                  Text('Has Error: ${_controller.hasError}'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _controller.loadCustomers,
                    child: const Text('Reload Customers'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_controller.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_controller.hasError)
            Card(
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error: ${_controller.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            )
          else if (_controller.customers.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No customers found'),
              ),
            )
          else
            ..._buildCustomersList(),
        ],
      ),
    );
  }

  List<Widget> _buildCustomersList() {
    return _controller.customers
        .map(
          (customer) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(customer.customerCode, style: TextStyle(color: Colors.grey[600])),
                  Text(customer.email, style: TextStyle(color: Colors.grey[600])),
                  Text('Balance: EGP ${customer.balance}'),
                  Text('Status: ${customer.status}'),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
