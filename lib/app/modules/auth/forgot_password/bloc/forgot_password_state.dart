part of '../../index.dart';

ForgotPwState ForgotPwInitialState = ForgotPwState(
  step: 0,
  status: ForgotPwStatus.nothing,
  callApiStatus: CallToServerStatus.normal,
  emailSController: TextEditingController(),
  passwordController: TextEditingController(),
  otpController: TextEditingController(),
  errorMessage: '',
  textButton: 'Forgot Password',
);

enum ForgotPwStatus { nothing, loading, backDialog }

const KEY_SEND_OTP_STORAGE = 'KEY_SEND_OTP_STORAGE';

enum CallToServerStatus {
  normal,
  failed,
  sendMailSuccess,
  sendOtpSuccess,
  sendNewPasswordSuccess,
}

class ForgotPwState {
  final ForgotPwStatus status;
  final CallToServerStatus callApiStatus;
  final TextEditingController emailSController;
  final TextEditingController passwordController;
  final TextEditingController otpController;
  final String errorMessage;
  final String textButton;
  final String? token;
  final int step;
  final int currentTime;
  const ForgotPwState({
    this.token,
    required this.step,
    required this.status,
    required this.callApiStatus,
    required this.emailSController,
    required this.passwordController,
    required this.otpController,
    required this.errorMessage,
    required this.textButton,
    this.currentTime = 0,
  });

  ForgotPwState copyWith({
    String? token,
    int? step,
    ForgotPwStatus? status,
    CallToServerStatus? callApiStatus,
    AuthPage? authPage,
    String? errorMessage,
    String? textButton,
    int? currentTime,
  }) {
    return ForgotPwState(
      token: token ?? this.token,
      step: step ?? this.step,
      otpController: otpController,
      status: status ?? this.status,
      emailSController: emailSController,
      passwordController: passwordController,
      textButton: textButton ?? this.textButton,
      errorMessage: errorMessage ?? this.errorMessage,
      callApiStatus: callApiStatus ?? this.callApiStatus,
      currentTime: currentTime ?? this.currentTime,
    );
  }
}
