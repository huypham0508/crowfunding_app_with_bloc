import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_modals.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_button_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_switch_page_button.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_title.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignUpView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpBloc(
          authRepository: AuthRepository(
            graphQLClient: context.read<GraphQLService>(),
            localDataSource: context.read<LocalDataSource>(),
          ),
        );
      },
      child: BlocConsumer<SignUpBloc, SignUpState>(listener: ((context, state) {
        switch (state.status) {
          case SignUpStatus.loading:
            showDialog(
              context: context,
              barrierColor: AppColors.black200.withOpacity(0.2),
              builder: (context) => loading(),
            );
            break;
          case SignUpStatus.registerSuccess:
            Utils.dialogNotification(
              context,
              'User registered successfully!!!',
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary600,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.check,
                  size: 20,
                  color: AppColors.whitish100,
                ),
              ),
            );
            Utils.setTimeout(
              () => authBloc.add(
                SwitchAuthPageEvent(authPage: AuthPage.signIn),
              ),
              2500,
            );
            break;
          case SignUpStatus.backDialog:
            context.pop();
            break;
          default:
        }
      }), builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTitle(
              titleString: FlutterI18n.translate(context, "auth.sign_up.title"),
            ),
            ErrorMessage(errorMessage: state.errorMessage),
            AnimatedContainer(
              duration: 500.milliseconds,
              child: Stack(
                children: [
                  _authInputsLoginContainer(
                    context,
                    state.signUpUsernameController,
                    state.signUpEmailSController,
                    state.signUpPasswordController,
                    state.signUpConfirmPwController,
                  ),
                  ButtonAuthCustom(
                    textColor: AppColors.black500,
                    backgroundColor: AppColors.whitish100,
                    onTap: () {
                      context.read<SignUpBloc>().add(
                            StartedSignUpEvent(
                              context: context,
                              registerModel: RegisterModel(
                                username: state.signUpUsernameController.text,
                                email: state.signUpEmailSController.text,
                                password: state.signUpPasswordController.text,
                                confirmPw: state.signUpConfirmPwController.text,
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            SwitchPageButton(
              onTap: () => authBloc.add(
                SwitchAuthPageEvent(authPage: AuthPage.signIn),
              ),
              text: FlutterI18n.translate(
                context,
                "auth.sign_in.do_not_have_account",
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _authInputsLoginContainer(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) {
    return FadeLinearToEaseOut(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          right: 70,
        ),
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral300.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputAuthCustom(
              textController: usernameController,
              hinText: FlutterI18n.translate(context, "auth.sign_up.username"),
              icon: const Icon(Icons.account_circle_rounded),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.username,
                        registerModel: RegisterModel(
                          username: value,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPw: confirmPasswordController.text,
                        ),
                      ),
                    );
              },
            ),
            InputAuthCustom(
              textController: emailController,
              hinText: FlutterI18n.translate(context, "auth.sign_up.email"),
              icon: const Icon(Icons.email),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.email,
                        registerModel: RegisterModel(
                          username: usernameController.text,
                          email: value,
                          password: passwordController.text,
                          confirmPw: confirmPasswordController.text,
                        ),
                      ),
                    );
              },
            ),
            InputAuthCustom(
              textController: passwordController,
              hinText: FlutterI18n.translate(context, "auth.sign_up.password"),
              icon: const Icon(Icons.lock),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
              obscureText: true,
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.password,
                        registerModel: RegisterModel(
                          username: usernameController.text,
                          email: emailController.text,
                          password: value,
                          confirmPw: confirmPasswordController.text,
                        ),
                      ),
                    );
              },
            ),
            InputAuthCustom(
              textController: confirmPasswordController,
              hinText: FlutterI18n.translate(
                context,
                "auth.sign_up.confirm_password",
              ),
              icon: const Icon(Icons.lock),
              obscureText: true,
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.confirmPassword,
                        registerModel: RegisterModel(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPw: value,
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.black500,
              strokeWidth: 1.8,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.whitish100,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
