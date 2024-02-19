import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_modals.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_button_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_switch_page_button.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_title.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignInView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignInBloc(
          authRepository: AuthRepository(
            graphQLClient: context.read<GraphQLService>(),
            localDataSource: context.read<LocalDataSource>(),
          ),
        );
      },
      child: BlocConsumer<SignInBloc, SignInState>(listener: ((context, state) {
        switch (state.status) {
          case SignInStatus.loading:
            showDialog(
              context: context,
              barrierColor: AppColors.lightBlack.withOpacity(0.2),
              builder: (context) => loading(),
            );
            break;
          case SignInStatus.loginSuccess:
            authBloc.add(InitialAuthEvent());
            break;
          case SignInStatus.backDialog:
            context.pop();
            break;
          default:
        }
      }), builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTitle(
              titleString: FlutterI18n.translate(context, "auth.sign_in.title"),
            ),
            ErrorMessage(errorMessage: state.errorMessage),
            AnimatedContainer(
              duration: 500.milliseconds,
              child: Stack(
                children: [
                  _authInputsLoginContainer(
                    context,
                    state.signInEmailSController,
                    state.signInPasswordController,
                  ),
                  ButtonAuthCustom(
                    onTap: () {
                      context.read<SignInBloc>().add(
                            StartedLoginEvent(
                              context: context,
                              loginModel: LoginModel(
                                email: state.signInEmailSController.text,
                                password: state.signInPasswordController.text,
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            SwitchPageButton(
              text: FlutterI18n.translate(
                context,
                "auth.sign_in.do_not_have_account",
              ),
              onTap: () => authBloc.add(
                SwitchAuthPageEvent(authPage: AuthPage.signUp),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _authInputsLoginContainer(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return FadeLinearToEaseOut(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          right: 70,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray_4.withOpacity(0.5),
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
              textController: emailController,
              hinText: FlutterI18n.translate(context, "auth.sign_in.email"),
              icon: const Icon(Icons.email),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
              onChange: (value) {
                context.read<SignInBloc>().add(
                      StartedLoginEvent(
                        context: context,
                        type: StartedLoginEventEnum.email,
                        loginModel: LoginModel(
                          email: value,
                          password: passwordController.text,
                        ),
                      ),
                    );
              },
            ),
            InputAuthCustom(
              textController: passwordController,
              hinText: FlutterI18n.translate(context, "auth.sign_in.password"),
              icon: const Icon(Icons.lock),
              obscureText: true,
              onChange: (value) => context.read<SignInBloc>().add(
                    StartedLoginEvent(
                      context: context,
                      type: StartedLoginEventEnum.password,
                      loginModel: LoginModel(
                        email: emailController.text,
                        password: value,
                      ),
                    ),
                  ),
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
              color: AppColors.black,
              strokeWidth: 1.8,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.lightWhite,
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
