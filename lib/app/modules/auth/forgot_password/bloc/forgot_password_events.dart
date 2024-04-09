part of 'forgot_password_bloc.dart';

enum StartedForgotPasswordEventEnum {
  email,
  otp,
  password,
  submitted,
}

abstract class ForgotPasswordEvent {}

class InitialForgotPasswordEvent extends ForgotPasswordEvent {}

class StartedForgotPasswordEvent extends ForgotPasswordEvent with Validate {
  final StartedForgotPasswordEventEnum type;
  final int step;
  final ForgotPasswordModel forgotPasswordModel;
  final List<String?> _validates = [];

  StartedForgotPasswordEvent({
    this.type = StartedForgotPasswordEventEnum.submitted,
    this.step = 0,
    required BuildContext context,
    required this.forgotPasswordModel,
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
    String email = forgotPasswordModel.email.trim();
    String password = forgotPasswordModel.password!.trim();
    String otp = forgotPasswordModel.OTP!.trim();

    switch (type) {
      case StartedForgotPasswordEventEnum.email:
        _validates.add(validateEmail(email));
        break;
      case StartedForgotPasswordEventEnum.otp:
        _validates.add(validateOTP(otp));
        break;
      case StartedForgotPasswordEventEnum.password:
        _validates.add(validatePassword(password));
        break;
      case StartedForgotPasswordEventEnum.submitted:
        if (step == 1) {
          _validates.add(validateEmail(email));
        }
        if (step == 2) {
          _validates.add(validateOTP(otp));
        }
        if (step == 3) {
          _validates.addAll([
            validateEmail(email),
            validatePassword(password),
          ]);
        }
        break;
      default:
    }
    return _validates;
  }
}

class SignInSwitchAuthPageEvent extends ForgotPasswordEvent {
  final AuthPage authPage;
  SignInSwitchAuthPageEvent({required this.authPage});
}
