import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _appLogo(size),
              _authStateString(),
              // _errorMessage(),
              SizedBox(
                height: size.height / 6,
                child: Stack(
                  children: [
                    _authInputsContainer(),
                    _confirmationButton(),
                  ],
                ),
              ),
              // _switchPageViewButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appLogo(Size size) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
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

  Widget _authInputsContainer() {
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
          _usernameField(),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _errorMessage() {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
      child: Text(
        'AppStrings.wrongLoginFields(context)',
        style: TextStyle(
          color: AppColors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 32.0),
      child: TextField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.account_circle_rounded),
            hintText: 'User name',
          ),
          onChanged: (value) {}),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 32),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock),
          hintText: 'Password',
        ),
        onChanged: (text) => {},
      ),
    );
  }

  Widget _confirmationButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
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
