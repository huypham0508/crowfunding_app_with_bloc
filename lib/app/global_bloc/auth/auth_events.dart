part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {}

class StartedLoginAuthEvent extends AuthEvent {
  final LoginModel loginModel;

  StartedLoginAuthEvent({required this.loginModel});

  String? validate() {
    List<String?> validates = [_validateEmail(), _validatePassword()];
    var value = validates.firstWhere((element) {
      return element.runtimeType == String;
    }, orElse: () => null);
    if (value.runtimeType == String) {
      return value;
    }
    return null;
  }

  String? _validateEmail() {
    if (loginModel.email.isEmpty) {
      return 'Please enter your email address!';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(loginModel.email)) {
      return 'Email address is invalid!';
    }
    return null;
  }

  String? _validatePassword() {
    if (loginModel.password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}
