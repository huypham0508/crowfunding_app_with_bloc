part of 'sign_in_bloc.dart';

enum StartedLoginEventEnum {
  email,
  password,
  submitted,
}

abstract class SignInEvent {}

class InitialSignInEvent extends SignInEvent {}

class StartedLoginEvent extends SignInEvent with Validate {
  final StartedLoginEventEnum type;
  final LoginModel loginModel;
  final List<String?> _validates = [];

  StartedLoginEvent({
    this.type = StartedLoginEventEnum.submitted,
    required BuildContext context,
    required this.loginModel,
  }) {
    setContext = context;
  }

  String? validate() {
    _generateValidations();
    return _validates.firstWhere(
      (element) => element != null,
      orElse: () => null,
    );
  }

  List<String?> _generateValidations() {
    String email = loginModel.email.trim();
    String password = loginModel.password.trim();

    switch (type) {
      case StartedLoginEventEnum.email:
        _validates.add(validateEmail(email));
        break;
      case StartedLoginEventEnum.password:
        _validates.add(validatePassword(password));
        break;
      default:
        _validates.addAll([
          validateEmail(email),
          validatePassword(password),
        ]);
    }
    return _validates;
  }
}

class SignInSwitchAuthPageEvent extends SignInEvent {
  final AuthPage authPage;
  SignInSwitchAuthPageEvent({required this.authPage});
}
