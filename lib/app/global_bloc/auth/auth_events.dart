part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {}

class StartedLoginAuthEvent extends AuthEvent {
  final LoginModel loginModel;
  final BuildContext context;

  StartedLoginAuthEvent({required this.context, required this.loginModel});

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
      return FlutterI18n.translate(context, "auth.sign_in.email_empty");
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(loginModel.email)) {
      return FlutterI18n.translate(context, "auth.sign_in.email_invalid");
    }
    return null;
  }

  String? _validatePassword() {
    if (loginModel.password.isEmpty) {
      return FlutterI18n.translate(context, "auth.sign_in.password_empty");
    }
    return null;
  }
}

class SwitchAuthPageEvent extends AuthEvent {
  final AuthPage authPage;
  SwitchAuthPageEvent({required this.authPage});
}
