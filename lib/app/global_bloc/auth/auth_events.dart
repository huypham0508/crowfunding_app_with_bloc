part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {}

class StartedLoginAuthEvent extends AuthEvent {
  final LoginModel loginModel;

  StartedLoginAuthEvent({required this.loginModel});
}
