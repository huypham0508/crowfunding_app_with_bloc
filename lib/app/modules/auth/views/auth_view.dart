import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/forgot_password/views/forgot_password_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/views/sign_in_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.whitish100,
          child: Center(
            child: FadeMoveLeftToRight(
              child: Container(
                margin: EdgeInsets.only(top: 14),
                width: size.width - 48,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.whitish100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    _appLogo(size),
                    _renderView(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appLogo(Size size) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return AnimatedPositioned(
        duration: 1700.milliseconds,
        curve: Curves.linear,
        left: 0,
        right: 0,
        top: state.authPage == AuthPage.splash ? (size.height / 4) : 30,
        bottom: null,
        child: Visibility(
          visible: state.authPage == AuthPage.splash,
          child: FadeScale(
            child: Container(
              color: AppColors.whitish100,
              child: Center(
                child: AnimatedContainer(
                  duration: 1700.milliseconds,
                  curve: Curves.easeIn,
                  width: state.authPage == AuthPage.splash
                      ? size.height / 2
                      : size.height / 3,
                  child: Image.asset(
                    AppImages.icLogo,
                    width: double.maxFinite,
                  ),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .scaleXY(
                      begin: 1.1,
                      end: 1,
                      duration: 1400.milliseconds,
                    )
                    .scaleXY(
                      delay: 1400.milliseconds,
                      begin: 1,
                      end: 1.1,
                      duration: 1400.milliseconds,
                    )
                    .shake(
                      delay: 2800.milliseconds,
                      duration: const Duration(milliseconds: 300),
                    ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _renderView() {
    return Positioned(
      child: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.loginSuccess:
                context.canPop();
                context.replace(Routes.HOME);
                break;
              default:
            }
          },
          builder: (context, state) {
            Widget containerWithLogo(content) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.authPage != AuthPage.splash) _logoApp(),
                  content,
                ],
              );
            }

            switch (state.authPage) {
              case AuthPage.signIn:
                return containerWithLogo(
                  SignInView(authBloc: authBloc),
                );
              case AuthPage.signUp:
                return containerWithLogo(
                  SignUpView(authBloc: authBloc),
                );
              case AuthPage.ForgotPw:
                return containerWithLogo(
                  ForgotPwView(authBloc: authBloc),
                );
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _logoApp() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: AppColors.neutral300,
        ),
      ),
      padding: EdgeInsets.all(5),
      child: Image.asset(
        AppImages.icLogoNoBg,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
