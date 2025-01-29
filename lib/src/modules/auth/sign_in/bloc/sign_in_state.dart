part of '../../index.dart';

SignInState signInInitialState = SignInState(
  status: SignInStatus.loginFailure,
  signInEmailSController: TextEditingController(),
  signInPasswordController: TextEditingController(),
  errorMessage: '',
  loginBiometric: false,
);

enum SignInStatus { loading, loginSuccess, loginFailure, backDialog }

class SignInState {
  final SignInStatus status;
  final TextEditingController signInEmailSController;
  final TextEditingController signInPasswordController;
  final String errorMessage;
  final bool loginBiometric;
  const SignInState({
    required this.status,
    required this.signInEmailSController,
    required this.signInPasswordController,
    required this.errorMessage,
    required this.loginBiometric,
  });

  SignInState copyWith({
    SignInStatus? status,
    AuthPage? authPage,
    String? errorMessage,
    bool? loginBiometric,
  }) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      signInEmailSController: signInEmailSController,
      signInPasswordController: signInPasswordController,
      loginBiometric: loginBiometric ?? this.loginBiometric,
    );
  }
}
