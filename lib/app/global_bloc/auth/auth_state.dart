part of 'auth_bloc.dart';

AuthState authInitialState = const AuthState(
  status: AuthStatus.loginFailure,
  authPage: AuthPage.splash,
);

enum AuthStatus { loginSuccess, loginFailure, signOut }

enum AuthPage { splash, signIn, signUp, ForgotPw }

class AuthState {
  final AuthStatus status;
  final AuthPage authPage;
  const AuthState({
    required this.status,
    required this.authPage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthPage? authPage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authPage: authPage ?? this.authPage,
    );
  }
}
