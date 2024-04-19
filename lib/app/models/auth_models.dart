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

class ForgotPwModel {
  final String email;
  final String? OTP;
  final String? password;
  String? token;
  ForgotPwModel({
    required this.email,
    this.token,
    this.OTP = '',
    this.password = '',
  });

  @override
  String toString() {
    return 'email: ${this.email}, token: ${this.token}, password: ${this.password}, otp: ${this.OTP}';
  }
}
