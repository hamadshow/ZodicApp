import 'package:flutter/foundation.dart';

import '../models/dashboard_models.dart';
import '../repository/dashboard_repository.dart';

class DashboardController extends ChangeNotifier {
  DashboardController({DashboardRepository? repository})
      : _repository = repository ?? DashboardRepository();

  final DashboardRepository _repository;

  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  DashboardData? _data;
  String _selectedPeriod = 'This Month';

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  DashboardData? get data => _data;
  String get selectedPeriod => _selectedPeriod;

  Future<void> loadDashboard({String period = 'This Month'}) async {
    _selectedPeriod = period;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _data = await _repository.getDashboardData(period: period);
    } catch (error) {
      _hasError = true;
      _errorMessage = 'Unable to load dashboard data.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadDashboard(period: _selectedPeriod);
  }
}
