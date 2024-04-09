part of 'forgot_password_bloc.dart';

ForgotPasswordState forgotPasswordInitialState = ForgotPasswordState(
  step: 0,
  status: ForgotPasswordStatus.forgotFailure,
  emailSController: TextEditingController(),
  passwordController: TextEditingController(),
  otpController: TextEditingController(),
  errorMessage: '',
);

enum ForgotPasswordStatus { loading, forgotSuccess, forgotFailure, backDialog }

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final TextEditingController emailSController;
  final TextEditingController passwordController;
  final TextEditingController otpController;
  final String errorMessage;
  final int step;
  const ForgotPasswordState({
    required this.step,
    required this.status,
    required this.emailSController,
    required this.passwordController,
    required this.otpController,
    required this.errorMessage,
  });

  ForgotPasswordState copyWith({
    int? step,
    ForgotPasswordStatus? status,
    AuthPage? authPage,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      emailSController: emailSController,
      passwordController: passwordController,
      otpController: otpController,
    );
  }
}
