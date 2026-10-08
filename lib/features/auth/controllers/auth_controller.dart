import 'package:flutter/foundation.dart';

import '../models/auth_models.dart';
import '../repository/auth_repository.dart';

enum AuthFlowState { idle, loading, success, error }

class AuthController extends ChangeNotifier {
  AuthController({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  bool _isLoading = false;
  bool _hasError = false;
  String? _message;
  AuthFlowState _state = AuthFlowState.idle;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get message => _message;
  AuthFlowState get state => _state;

  Future<bool> login({
    required String identifier,
    required String password,
    required bool rememberMe,
  }) async {
    _isLoading = true;
    _hasError = false;
    _message = null;
    _state = AuthFlowState.loading;
    notifyListeners();

    final result = await _repository.login(
      LoginRequest(
        identifier: identifier,
        password: password,
        rememberMe: rememberMe,
      ),
    );

    _isLoading = false;
    if (result.success) {
      _state = AuthFlowState.success;
      _message = result.message;
      _hasError = false;
      notifyListeners();
      return true;
    }

    _state = AuthFlowState.error;
    _message = result.message;
    _hasError = true;
    notifyListeners();
    return false;
  }

  Future<bool> sendResetLink({required String email}) async {
    _isLoading = true;
    _hasError = false;
    _message = null;
    _state = AuthFlowState.loading;
    notifyListeners();

    final isSent = await _repository.sendResetLink(ForgotPasswordRequest(email: email));

    _isLoading = false;
    if (isSent) {
      _state = AuthFlowState.success;
      _message = 'Reset link sent';
      _hasError = false;
      notifyListeners();
      return true;
    }

    _state = AuthFlowState.error;
    _message = 'Unable to send reset link. Please try again.';
    _hasError = true;
    notifyListeners();
    return false;
  }

  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _hasError = false;
    _message = null;
    _state = AuthFlowState.loading;
    notifyListeners();

    final success = await _repository.resetPassword(
      ResetPasswordRequest(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );

    _isLoading = false;
    if (success) {
      _state = AuthFlowState.success;
      _message = 'Password Reset Successfully';
      _hasError = false;
      notifyListeners();
      return true;
    }

    _state = AuthFlowState.error;
    _message = 'Unable to reset password. Please check the form and try again.';
    _hasError = true;
    notifyListeners();
    return false;
  }

  void clearState() {
    _isLoading = false;
    _hasError = false;
    _message = null;
    _state = AuthFlowState.idle;
    notifyListeners();
  }
}
