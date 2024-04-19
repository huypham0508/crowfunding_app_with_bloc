part of 'sign_up_bloc.dart';

enum StartedSignUpEventEnum {
  username,
  email,
  password,
  confirmPassword,
  submitted,
}

abstract class SignUpEvent {}

class InitialSignUpEvent extends SignUpEvent {}

class StartedSignUpEvent extends SignUpEvent with Validate {
  final StartedSignUpEventEnum type;
  final RegisterModel registerModel;
  final List<String?> _validates = [];

  StartedSignUpEvent({
    this.type = StartedSignUpEventEnum.submitted,
    required BuildContext context,
    required this.registerModel,
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
    String username = registerModel.username;
    String email = registerModel.email;
    String password = registerModel.password;
    String confirmPw = registerModel.confirmPw;

    switch (type) {
      case StartedSignUpEventEnum.username:
        _validates.add(validateUsername(username));
        break;
      case StartedSignUpEventEnum.email:
        _validates.add(validateEmail(email));
        break;
      case StartedSignUpEventEnum.password:
        _validates.add(validatePasswordStrength(password));
        break;
      case StartedSignUpEventEnum.confirmPassword:
        _validates.add(validateConfirmPassword(confirmPw, password));
        break;
      default:
        _validates.addAll([
          validateUsername(username),
          validateEmail(email),
          validatePasswordStrength(password),
          validateConfirmPassword(confirmPw, password),
        ]);
    }

    return _validates;
  }
}
