part of 'forgot_password_bloc.dart';

enum StartedForgotPwEventEnum {
  email,
  otp,
  password,
  submitted,
}

abstract class ForgotPwEvent {}

class InitialForgotPwEvent extends ForgotPwEvent {}

class StartedForgotPwEvent extends ForgotPwEvent with Validate {
  final int step;
  final String? textNext;
  final List<String?> _validates = [];
  final StartedForgotPwEventEnum type;
  final ForgotPwModel forgotPwModel;

  StartedForgotPwEvent({
    this.step = 0,
    this.textNext,
    required BuildContext context,
    required this.forgotPwModel,
    this.type = StartedForgotPwEventEnum.submitted,
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
    String email = forgotPwModel.email.trim();
    String password = forgotPwModel.password!.trim();
    String otp = forgotPwModel.OTP!.trim();

    switch (type) {
      case StartedForgotPwEventEnum.email:
        _validates.add(validateEmail(email));
        break;
      case StartedForgotPwEventEnum.otp:
        _validates.add(validateOTP(otp));
        break;
      case StartedForgotPwEventEnum.password:
        _validates.add(validatePasswordStrength(password));
        break;
      case StartedForgotPwEventEnum.submitted:
        if (step == 0) {
          _validates.add(validateEmail(email));
        }
        if (step == 1) {
          _validates.add(validateOTP(otp));
        }
        if (step == 2) {
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

class ClosePopupForgotPwEvent extends ForgotPwEvent {}

class BackModelForgotPwEvent extends ForgotPwEvent {}
