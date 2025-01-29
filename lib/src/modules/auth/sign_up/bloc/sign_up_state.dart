part of '../../index.dart';

SignUpState signUpInitialState = SignUpState(
  status: SignUpStatus.registerFailure,
  signUpEmailSController: TextEditingController(),
  signUpPasswordController: TextEditingController(),
  signUpUsernameController: TextEditingController(),
  signUpConfirmPwController: TextEditingController(),
  errorMessage: '',
);

enum SignUpStatus { loading, registerSuccess, registerFailure, backDialog }

class SignUpState {
  final SignUpStatus status;
  final TextEditingController signUpUsernameController;
  final TextEditingController signUpEmailSController;
  final TextEditingController signUpPasswordController;
  final TextEditingController signUpConfirmPwController;
  final String errorMessage;
  const SignUpState({
    required this.status,
    required this.signUpUsernameController,
    required this.signUpEmailSController,
    required this.signUpPasswordController,
    required this.signUpConfirmPwController,
    required this.errorMessage,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    AuthPage? authPage,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      signUpUsernameController: signUpUsernameController,
      signUpEmailSController: signUpEmailSController,
      signUpPasswordController: signUpPasswordController,
      signUpConfirmPwController: signUpConfirmPwController,
    );
  }
}
