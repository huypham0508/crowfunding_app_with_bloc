import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatelessWidget {
  final AuthBloc authBloc;
  const ForgotPasswordView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return FadeMoveLeftToRight(
      child: BlocProvider(
        create: (context) {
          return ForgotPasswordBloc(
            authRepository: AuthRepository(
              graphQLClient: context.read<GraphQLService>(),
              localDataSource: context.read<LocalDataSource>(),
            ),
          );
        },
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: ((
            context,
            state,
          ) {
            switch (state.status) {
              case ForgotPasswordStatus.loading:
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: AppColors.black300.withOpacity(0.2),
                  builder: (context) => Utils.loading(loading: 'Loading...'),
                );
                break;
              case ForgotPasswordStatus.forgotSuccess:
                authBloc.add(CheckAuthEvent());
                break;
              case ForgotPasswordStatus.backDialog:
                context.pop();
                break;
              default:
            }
          }),
          builder: (context, state) {
            return ContainerForgotPassword(
              children: [
                _titlePage(context),
                GlobalStyles.sizedBoxHeight_24,
                ..._inputs(state, context),
                _buttonSubmit(
                  context: context,
                  onTap: () {
                    context.read<ForgotPasswordBloc>().add(
                          StartedForgotPasswordEvent(
                            context: context,
                            type: StartedForgotPasswordEventEnum.submitted,
                            step: state.step + 1,
                            forgotPasswordModel: ForgotPasswordModel(
                              email: state.emailSController.text,
                              OTP: state.otpController.text,
                              password: state.passwordController.text,
                            ),
                          ),
                        );
                  },
                ),
                _toSignIn(
                    text: 'Back to Sign In',
                    onPressed: () {
                      authBloc.add(
                        SwitchAuthPageEvent(
                          authPage: AuthPage.signIn,
                        ),
                      );
                    })
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _titlePage(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        FlutterI18n.translate(
          context,
          "auth.forgot_password.title",
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.black100,
        ),
      ),
    );
  }

  List<Widget> _inputs(
    ForgotPasswordState forgotPasswordState,
    BuildContext context,
  ) {
    return [
      ErrorMessage(errorMessage: forgotPasswordState.errorMessage),
      if (forgotPasswordState.step == 0)
        InputAuthCustom(
          textController: forgotPasswordState.emailSController,
          hinText: 'example@gmail.com',
          title: 'Email *',
          onChange: (value) {
            context.read<ForgotPasswordBloc>().add(
                  StartedForgotPasswordEvent(
                    context: context,
                    type: StartedForgotPasswordEventEnum.email,
                    forgotPasswordModel: ForgotPasswordModel(
                      email: value,
                    ),
                  ),
                );
          },
        ),
      if (forgotPasswordState.step == 1)
        InputAuthCustom(
          textController: forgotPasswordState.otpController,
          hinText: 'OTP',
          title: 'OTP',
          onChange: (value) {
            context.read<ForgotPasswordBloc>().add(
                  StartedForgotPasswordEvent(
                    context: context,
                    type: StartedForgotPasswordEventEnum.otp,
                    forgotPasswordModel: ForgotPasswordModel(
                      email: forgotPasswordState.emailSController.text,
                      OTP: value,
                    ),
                  ),
                );
          },
        ),
      if (forgotPasswordState.step == 2)
        InputAuthCustom(
          textController: forgotPasswordState.emailSController,
          hinText: 'Your password',
          title: 'Password',
          onChange: (value) {
            context.read<ForgotPasswordBloc>().add(
                  StartedForgotPasswordEvent(
                    context: context,
                    type: StartedForgotPasswordEventEnum.email,
                    forgotPasswordModel: ForgotPasswordModel(
                      email: value,
                    ),
                  ),
                );
          },
        ),
      const SizedBox(height: 5),
      GlobalStyles.sizedBoxHeight_24,
    ];
  }

  Widget _toSignIn({required String text, void Function()? onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.primary600,
        ),
      ),
    );
  }

  Widget _buttonSubmit({
    void Function()? onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Container(
          width: double.maxFinite,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColors.primary600,
            ),
            color: AppColors.primary600,
          ),
          child: Center(
            child: Text(
              FlutterI18n.translate(
                context,
                "auth.forgot_password.title",
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.whitish100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerForgotPassword extends StatelessWidget {
  const ContainerForgotPassword({
    super.key,
    required this.children,
  });

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return BoxShadowCustom(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
