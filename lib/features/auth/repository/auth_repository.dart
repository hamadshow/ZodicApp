import '../models/auth_models.dart';
import '../services/auth_mock_service.dart';

class AuthRepository {
  AuthRepository({AuthMockService? service}) : _service = service ?? AuthMockService();

  final AuthMockService _service;

  Future<LoginResult> login(LoginRequest request) => _service.login(request);

  Future<bool> sendResetLink(ForgotPasswordRequest request) =>
      _service.sendResetLink(request);

  Future<bool> resetPassword(ResetPasswordRequest request) =>
      _service.resetPassword(request);
}
