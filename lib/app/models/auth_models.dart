class LoginModel {
  final String email;
  final String password;
  LoginModel({required this.email, required this.password});
}

class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String confirmPw;
  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    this.confirmPw = "",
  });
}

class ForgotPasswordModel {
  final String email;
  final String? OTP;
  final String? token;
  final String? password;
  ForgotPasswordModel({
    required this.email,
    this.token,
    this.OTP = '',
    this.password = '',
  });
}
