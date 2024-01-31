import 'package:crowfunding_app_with_bloc/app/constants/app_colors.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Email'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                GlobalStyles.sizedBoxHeight_30,
                const Text('Password'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                GlobalStyles.sizedBoxHeight_10,
                GestureDetector(
                  onTap: () => BlocProvider.of<AuthBloc>(context).add(
                    StartedLoginAuthEvent(
                      loginModel: LoginModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      border: Border.all(
                        width: 1,
                        color: AppColors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
              'Đang tải...',
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
