class LoginRequest {
  final String identifier;
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.identifier,
    required this.password,
    this.rememberMe = false,
  });
}

class LoginResult {
  final bool success;
  final String message;
  final String? userName;

  LoginResult({
    required this.success,
    required this.message,
    this.userName,
  });
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});
}

class ResetPasswordRequest {
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.newPassword,
    required this.confirmPassword,
  });
}
