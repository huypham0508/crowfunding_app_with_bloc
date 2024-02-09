part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class InitialSignUpEvent extends SignUpEvent {}

class StartedSignUpEvent extends SignUpEvent {
  final RegisterModel registerModel;
  final BuildContext context;

  StartedSignUpEvent({required this.context, required this.registerModel});

  String? validate() {
    List<String?> validates = [
      _validateUsername(),
      _validateEmail(),
      _validatePassword(),
      _validateConfirmPassword(),
    ];
    var value = validates.firstWhere((element) {
      return element.runtimeType == String;
    }, orElse: () => null);
    if (value.runtimeType == String) {
      return value;
    }
    return null;
  }

  String? _validateUsername() {
    if (registerModel.username.isEmpty) {
      return FlutterI18n.translate(context, "auth.sign_up.username_empty");
    }
    return null;
  }

  String? _validateEmail() {
    if (registerModel.email.isEmpty) {
      return FlutterI18n.translate(context, "auth.sign_up.email_empty");
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
      registerModel.email,
    )) {
      return FlutterI18n.translate(context, "auth.sign_in.email_invalid");
    }
    return null;
  }

  String? _validatePassword() {
    if (registerModel.password.isEmpty) {
      return FlutterI18n.translate(context, "auth.sign_up.password_empty");
    } else if (registerModel.password.length < 6) {
      return FlutterI18n.translate(context, "auth.sign_up.passwords_least");
    }
    return null;
  }

  String? _validateConfirmPassword() {
    if (registerModel.confirmPw.isEmpty) {
      return FlutterI18n.translate(
        context,
        "auth.sign_up.confirm_password_empty",
      );
    } else if (registerModel.confirmPw != registerModel.password) {
      return FlutterI18n.translate(
        context,
        "auth.sign_up.confirm_password_not_match",
      );
    }
    return null;
  }
}

class SignUpSwitchAuthPageEvent extends SignUpEvent {
  final AuthPage authPage;
  SignUpSwitchAuthPageEvent({required this.authPage});
}
