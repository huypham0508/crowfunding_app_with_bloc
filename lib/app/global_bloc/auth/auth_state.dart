part of 'auth_bloc.dart';

AuthState authInitialState = AuthState(
  status: AuthStatus.loginFailure,
  authPage: AuthPage.splash,
  emailController: TextEditingController(),
  passwordController: TextEditingController(),
  errorMessage: '',
);

enum AuthStatus { loading, loginSuccess, loginFailure, backDialog }

enum AuthPage { splash, signIn, signUp, forgotPassword }

class AuthState {
  final AuthStatus status;
  final AuthPage authPage;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;
  const AuthState({
    required this.status,
    required this.authPage,
    required this.emailController,
    required this.passwordController,
    required this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthPage? authPage,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authPage: authPage ?? this.authPage,
      errorMessage: errorMessage ?? this.errorMessage,
      emailController: emailController,
      passwordController: passwordController,
    );
  }
}
