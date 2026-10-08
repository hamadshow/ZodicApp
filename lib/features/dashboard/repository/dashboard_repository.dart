import '../models/dashboard_models.dart';
import '../services/dashboard_mock_service.dart';

class DashboardRepository {
  DashboardRepository({DashboardMockService? service})
      : _service = service ?? DashboardMockService();

  final DashboardMockService _service;

  Future<DashboardData> getDashboardData({String period = 'This Month'}) =>
      _service.getDashboardData(period: period);
}
