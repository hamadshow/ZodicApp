import 'package:flutter/foundation.dart';

import '../models/customer.dart';
import '../models/customer_summary.dart';
import '../repository/customer_repository.dart';

class CustomerController extends ChangeNotifier {
  CustomerController({CustomerRepository? repository})
      : _repository = repository ?? CustomerRepository();

  final CustomerRepository _repository;

  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  List<Customer> _customers = const [];
  CustomerSummary? _summary;
  String _query = '';
  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _balanceFilter = 'All';
  String _sortBy = 'name';
  bool _ascending = true;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  List<Customer> get customers => _customers;
  CustomerSummary? get summary => _summary;
  String get query => _query;
  String get statusFilter => _statusFilter;
  String get typeFilter => _typeFilter;
  String get balanceFilter => _balanceFilter;
  String get sortBy => _sortBy;
  bool get isAscending => _ascending;

  Future<void> loadCustomers() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final customers = await _repository.getCustomers();
      _customers = customers;
      _summary = await _repository.getCustomerSummary();
    } catch (_) {
      _hasError = true;
      _errorMessage = 'Unable to load customers.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadCustomers();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setStatusFilter(String value) {
    _statusFilter = value;
    notifyListeners();
  }

  void setTypeFilter(String value) {
    _typeFilter = value;
    notifyListeners();
  }

  void setBalanceFilter(String value) {
    _balanceFilter = value;
    notifyListeners();
  }

  void resetFilters() {
    _query = '';
    _statusFilter = 'All';
    _typeFilter = 'All';
    _balanceFilter = 'All';
    notifyListeners();
  }

  void setSort(String field, bool ascending) {
    _sortBy = field;
    _ascending = ascending;
    notifyListeners();
  }

  List<Customer> get filteredCustomers {
    final lowercaseQuery = _query.trim().toLowerCase();

    var list = _customers.where((customer) {
      final matchesQuery = lowercaseQuery.isEmpty ||
          customer.name.toLowerCase().contains(lowercaseQuery) ||
          customer.customerCode.toLowerCase().contains(lowercaseQuery) ||
          customer.phone.toLowerCase().contains(lowercaseQuery) ||
          customer.email.toLowerCase().contains(lowercaseQuery);

      final matchesStatus = _statusFilter == 'All' || customer.status == _statusFilter;
      final matchesType = _typeFilter == 'All' || customer.type == _typeFilter;
      final matchesBalance = _balanceFilter == 'All' ||
          (_balanceFilter == 'Has Balance' && customer.balance > 0) ||
          (_balanceFilter == 'No Balance' && customer.balance <= 0);

      return matchesQuery && matchesStatus && matchesType && matchesBalance;
    }).toList();

    list.sort((a, b) {
      int comparison = 0;
      switch (_sortBy) {
        case 'code':
          comparison = a.customerCode.compareTo(b.customerCode);
          break;
        case 'balance':
          comparison = a.balance.compareTo(b.balance);
          break;
        case 'created':
          comparison = a.createdAt.compareTo(b.createdAt);
          break;
        case 'name':
        default:
          comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
      }
      return _ascending ? comparison : -comparison;
    });

    return list;
  }

  Future<void> deleteCustomer(String customerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteCustomer(customerId);
      _customers = _customers.where((customer) => customer.id != customerId).toList();
      _summary = await _repository.getCustomerSummary();
    } catch (_) {
      _hasError = true;
      _errorMessage = 'Unable to delete customer.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.saveCustomer(customer);
      final index = _customers.indexWhere((item) => item.id == customer.id);
      if (index != -1) {
        _customers[index] = customer;
      }
      _summary = await _repository.getCustomerSummary();
    } catch (_) {
      _hasError = true;
      _errorMessage = 'Unable to save customer.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCustomer(Customer customer) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.saveCustomer(customer);
      _customers = [customer, ..._customers];
      _summary = await _repository.getCustomerSummary();
    } catch (_) {
      _hasError = true;
      _errorMessage = 'Unable to add customer.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleCustomerStatus(Customer customer) {
    final updated = customer.copyWith(
      status: customer.status == CustomerStatus.active ? CustomerStatus.inactive : CustomerStatus.active,
      updatedAt: DateTime.now(),
    );

    final index = _customers.indexWhere((item) => item.id == customer.id);
    if (index != -1) {
      _customers[index] = updated;
      notifyListeners();
    }
  }
}
