import 'dart:async';

import '../models/auth_models.dart';

class AuthMockService {
  static const _demoIdentifier = 'admin@zodic.com';
  static const _demoPassword = 'Admin@123';

  Future<LoginResult> login(LoginRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final identifier = request.identifier.trim();
    final password = request.password.trim();
    final matchesDemo = identifier.toLowerCase() == _demoIdentifier &&
        password == _demoPassword;
    final isValidRandomUser =
        (identifier.contains('@') && identifier.contains('.')) &&
            password.length >= 6;

    if (!matchesDemo && !isValidRandomUser) {
      return LoginResult(
        success: false,
        message: 'Unable to sign in. Please check your email and password.',
      );
    }

    final userName = identifier.contains('@')
        ? identifier.split('@').first
        : 'Demo User';

    return LoginResult(
      success: true,
      message: 'Login successful',
      userName: userName[0].toUpperCase() + userName.substring(1),
    );
  }

  Future<bool> sendResetLink(ForgotPasswordRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final isValid = request.email.trim().isNotEmpty && request.email.contains('@');
    return isValid;
  }

  Future<bool> resetPassword(ResetPasswordRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return request.newPassword.length >= 6 &&
        request.newPassword == request.confirmPassword;
  }
}
