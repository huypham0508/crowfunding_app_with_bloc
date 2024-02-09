import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
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
              barrierColor: AppColors.lightBlack.withOpacity(0.2),
              builder: (context) => loading(),
            );
            break;
          case SignUpStatus.registerSuccess:
            Utils.dialogNotification(
              context,
              'User registered successfully!!!',
              Container(
                decoration: BoxDecoration(
                  color: AppColors.green_2,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.check,
                  size: 20,
                  color: AppColors.lightWhite,
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
                    state.signUpUsernameController,
                    state.signUpEmailSController,
                    state.signUpPasswordController,
                    state.signUpConfirmPwController,
                  ),
                  ButtonAuthCustom(
                    textColor: AppColors.black,
                    backgroundColor: AppColors.lightWhite,
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
    usernameController,
    emailController,
    passwordController,
    confirmPasswordController,
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
              textController: usernameController,
              hinText: 'Username',
              icon: const Icon(Icons.account_circle_rounded),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
            ),
            InputAuthCustom(
              textController: emailController,
              hinText: 'Your email',
              icon: const Icon(Icons.email),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
            ),
            InputAuthCustom(
              textController: passwordController,
              hinText: 'Your password',
              icon: const Icon(Icons.lock),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 32.0,
                bottom: 10,
              ),
              obscureText: true,
            ),
            InputAuthCustom(
              textController: confirmPasswordController,
              hinText: 'Confirm password',
              icon: const Icon(Icons.lock),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget loading() {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.black,
              strokeWidth: 1.8,
            ),
            const SizedBox(
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
