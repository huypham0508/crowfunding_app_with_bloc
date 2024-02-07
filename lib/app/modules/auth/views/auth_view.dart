import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_background.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.loading:
                  showDialog(
                    context: context,
                    barrierColor: AppColors.lightBlack.withOpacity(0.2),
                    builder: (context) => loading(),
                  );
                  break;
                case AuthStatus.loginSuccess:
                  context.pushReplacement(Routes.LOTO);
                  break;
                case AuthStatus.backDialog:
                  context.pop();
                  break;
                default:
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _appLogo(size),
                  _authStateString(),
                  _errorMessage(state),
                  SizedBox(
                    height: size.height / 6,
                    child: Stack(
                      children: [
                        _authInputsContainer(state),
                        _confirmationButton(authBloc),
                      ],
                    ),
                  ),
                  // _switchPageViewButton(),
                ],
              );
            },
          ),
        ],
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
              color: AppColors.greenMoss,
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
    return Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
      // child: Image.asset(
      //   AppImages.icLogo,
      //   width: size.height / 8,
      // ),
      child: FlutterLogo(
        size: size.height / 8,
        style: FlutterLogoStyle.markOnly,
      ),
    );
  }

  Widget _authStateString() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 32.0, bottom: 24),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _authInputsContainer(AuthState state) {
    return Container(
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
          _usernameField(state.emailController),
          _passwordField(state.passwordController),
        ],
      ),
    );
  }

  Widget _errorMessage(AuthState state) {
    return state.errorMessage.runtimeType == String
        ? Container(
            margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
            child: Text(
              state.errorMessage,
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _usernameField(emailController) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 32.0),
      child: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.account_circle_rounded),
            hintText: 'User name',
          ),
          onChanged: (value) {}),
    );
  }

  Widget _passwordField(passwordController) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 32),
      child: TextField(
        controller: passwordController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock),
          hintText: 'Password',
        ),
        onChanged: (text) => {},
      ),
    );
  }

  Widget _confirmationButton(AuthBloc authBloc) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => authBloc.add(
          StartedLoginAuthEvent(
            loginModel: LoginModel(
              email: authBloc.state.emailController.text,
              password: authBloc.state.passwordController.text,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(right: 24.0),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
          child: Icon(
            Icons.arrow_forward_outlined,
            color: AppColors.lightWhite,
            size: 32,
          ),
        ),
      ),
    );
  }
}
