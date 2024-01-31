part of 'auth_bloc.dart';

const authInitialState = AuthState(
  status: AuthStatus.loginFailure,
);

enum AuthStatus { loading, loginSuccess, loginFailure, backDialog }

class AuthState {
  final AuthStatus status;
  const AuthState({
    required this.status,
  });

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
