part of '../../index.dart';

class ForgotPwView extends StatelessWidget {
  final AuthBloc authBloc;
  const ForgotPwView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return FadeMoveLeftToRight(
      child: BlocProvider(
        create: (context) {
          return ForgotPwBloc(
            authRepository: AuthRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
              localDataSource: context.read<LocalDataSource>(),
            ),
          );
        },
        child: BlocConsumer<ForgotPwBloc, ForgotPwState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: ((context, state) {
            switch (state.status) {
              case ForgotPwStatus.loading:
                Utils.showLoading(context);
                break;
              case ForgotPwStatus.backDialog:
                Utils.closeLoading(context);
                break;
              default:
            }
          }),
          builder: (context, state) {
            Map<int, String> buttonText = {
              0: 'Forgot Password',
              1: 'Submit OTP',
              2: 'Reset Password',
              3: 'Back to Sign In'
            };

            return Stack(
              children: [
                ContainerForgotPw(
                  children: [
                    AuthTitle(
                      titleString: FlutterI18n.translate(
                        context,
                        "auth.forgot_password.title",
                      ),
                    ),
                    GlobalStyles.sizedBoxHeight_24,
                    ..._inputs(state, context),
                    ButtonAuthCustom(
                        context: context,
                        text: state.textButton,
                        onTap: () {
                          if (state.step == 3) {
                            authBloc.add(
                              SwitchAuthPageEvent(
                                authPage: AuthPage.signIn,
                              ),
                            );
                          } else {
                            context.read<ForgotPwBloc>().add(
                                  StartedForgotPwEvent(
                                    context: context,
                                    step: state.step,
                                    textNext: buttonText[state.step + 1],
                                    type: StartedForgotPwEventEnum.submitted,
                                    forgotPwModel: ForgotPwModel(
                                      email: state.emailSController.text,
                                      OTP: state.otpController.text,
                                      password: state.passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        }),
                    GlobalStyles.sizedBoxHeight_5,
                    if (state.step < 3)
                      ToPage(
                        text: 'Back to Sign In',
                        onPressed: () {
                          authBloc.add(
                            SwitchAuthPageEvent(
                              authPage: AuthPage.signIn,
                            ),
                          );
                        },
                      )
                  ],
                ),
                //show when enter email successfully
                if (state.callApiStatus == CallToServerStatus.sendMailSuccess)
                  _sendMailSuccess(context, state.emailSController.text),
                //show when verify otp successfully
                if (state.callApiStatus == CallToServerStatus.sendOtpSuccess)
                  _sendOTPSuccess(context),
                //show when reset password successfully
                if (state.callApiStatus ==
                    CallToServerStatus.sendNewPasswordSuccess)
                  _sendResetPwSuccess(context),
              ],
            );
          },
        ),
      ),
    );
  }

  PopupNotify _sendMailSuccess(BuildContext context, String email) {
    return PopupNotify(
      type: popUpType.SUCCESS,
      textPrimary: FlutterI18n.translate(
        context,
        "auth.forgot_password.check_inbox",
      ),
      textSecondary: FlutterI18n.translate(
        context,
        "auth.forgot_password.send_to_email",
      ),
      textSecondaryHighlight: email,
    );
  }

  PopupNotify _sendOTPSuccess(BuildContext context) {
    return PopupNotify(
      type: popUpType.SUCCESS,
      textPrimary: FlutterI18n.translate(
        context,
        "auth.forgot_password.send_otp_success",
      ),
    );
  }

  PopupNotify _sendResetPwSuccess(BuildContext context) {
    return PopupNotify(
      type: popUpType.SUCCESS,
      textPrimary: FlutterI18n.translate(
        context,
        "auth.forgot_password.reset_password_success",
      ),
    );
  }

  List<Widget> _inputs(
    ForgotPwState ForgotPwState,
    BuildContext context,
  ) {
    return [
      ErrorMessage(errorMessage: ForgotPwState.errorMessage),
      if (ForgotPwState.step == 0)
        InputAuthCustom(
          textController: ForgotPwState.emailSController,
          hinText: 'example@gmail.com',
          title: 'Email *',
          onChange: (value) {
            context.read<ForgotPwBloc>().add(
                  StartedForgotPwEvent(
                    context: context,
                    type: StartedForgotPwEventEnum.email,
                    forgotPwModel: ForgotPwModel(
                      email: value,
                    ),
                  ),
                );
          },
        ),
      if (ForgotPwState.step == 1)
        Container(
          width: double.maxFinite,
          child: FittedBox(
            child: OtpTextField(
              borderWidth: 0.5,
              numberOfFields: 6,
              showFieldAsBox: true,
              cursorColor: AppColors.black100,
              borderColor: AppColors.neutral300,
              focusedBorderColor: AppColors.primary600,
              keyboardType: TextInputType.number,
              onCodeChanged: (String code) {
                ForgotPwState.otpController.text = code;
              },
              onSubmit: (String verificationCode) {
                ForgotPwState.otpController.text = verificationCode;
              }, // end onSubmit
            ),
          ),
        ).animate(delay: 600.ms),
      if (ForgotPwState.step == 2)
        InputAuthCustom(
          textController: ForgotPwState.passwordController,
          hinText: 'Your password',
          title: 'Password',
          obscureText: true,
          onChange: (value) {
            context.read<ForgotPwBloc>().add(
                  StartedForgotPwEvent(
                    context: context,
                    type: StartedForgotPwEventEnum.password,
                    forgotPwModel: ForgotPwModel(
                      email: ForgotPwState.emailSController.text,
                      OTP: ForgotPwState.otpController.text,
                      password: value,
                    ),
                  ),
                );
          },
        ),
      const SizedBox(height: 5),
      GlobalStyles.sizedBoxHeight_24,
    ];
  }
}
