import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/views/sign_in_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_background.dart';
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
      body: Stack(
        children: [
          _background(),
          _appLogo(size),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.loginSuccess:
                  context.pushReplacement(Routes.HOME);
                  break;
                default:
              }
            },
            builder: (context, state) {
              switch (state.authPage) {
                case AuthPage.signIn:
                  return SignInView(authBloc: authBloc);
                case AuthPage.signUp:
                  return SignUpView(authBloc: authBloc);
                default:
                  return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state.authPage == AuthPage.signUp
          ? const BackgroundDark()
          : const Background(),
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

  Widget _appLogo(Size size) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return AnimatedPositioned(
        duration: 1700.milliseconds,
        curve: Curves.linear,
        left: 0,
        right: 0,
        top: state.authPage == AuthPage.splash ? (size.height / 3) : 30,
        bottom: null,
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
      );
    });
  }
}
// FlutterLogo(
//   size: size.height / 8,
//   style: FlutterLogoStyle.markOnly,
// ),