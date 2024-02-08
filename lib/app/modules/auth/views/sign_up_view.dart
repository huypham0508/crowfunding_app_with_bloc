import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_button_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_switch_page_button.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_title.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignUpView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignUpView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTitle(
            titleString: FlutterI18n.translate(context, "auth.sign_up.title"),
          ),
          ErrorMessage(errorMessage: state.errorMessage),
          AnimatedContainer(
            duration: 500.milliseconds,
            height: size.height / 6,
            child: Stack(
              children: [
                _authInputsLoginContainer(
                  state.emailController,
                  state.passwordController,
                ),
                ButtonAuthCustom(onTap: () {}),
              ],
            ),
          ),
          SwitchPageButton(
            text: FlutterI18n.translate(
              context,
              "auth.sign_up.have_account",
            ),
            onTap: () => authBloc.add(
              SwitchAuthPageEvent(authPage: AuthPage.signIn),
            ),
          ),
        ],
      );
    });
  }

  Widget _authInputsLoginContainer(emailController, passwordController) {
    return FadeLinearToEaseOut(
      child: Container(
        height: 150,
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
              hinText: 'Your email',
              icon: const Icon(Icons.account_circle_rounded),
            ),
            InputAuthCustom(
              textController: passwordController,
              hinText: 'Your password',
              icon: const Icon(Icons.lock),
            ),
          ],
        ),
      ),
    );
  }
}
