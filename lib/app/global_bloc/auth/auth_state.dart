part of 'auth_bloc.dart';

AuthState authInitialState = AuthState(
    status: AuthStatus.loginFailure,
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
    errorMessage: '');

enum AuthStatus { loading, loginSuccess, loginFailure, backDialog }

class AuthState {
  final AuthStatus status;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;
  const AuthState({
    required this.status,
    required this.emailController,
    required this.passwordController,
    required this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      emailController: emailController,
      passwordController: passwordController,
    );
  }
}
