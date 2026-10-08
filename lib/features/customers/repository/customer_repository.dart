import '../models/customer.dart';
import '../models/customer_summary.dart';
import '../services/customer_mock_service.dart';

class CustomerRepository {
  CustomerRepository({CustomerMockService? service}) : _service = service ?? CustomerMockService();

  final CustomerMockService _service;

  Future<List<Customer>> getCustomers() => _service.getCustomers();

  Future<CustomerSummary> getCustomerSummary() => _service.getCustomerSummary();

  Future<Customer?> getCustomerById(String id) async {
    final customers = await getCustomers();
    return customers.where((customer) => customer.id == id).firstOrNull;
  }

  Future<void> saveCustomer(Customer customer) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
  }

  Future<void> deleteCustomer(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
