part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {
  final BuildContext context;
  InitialAuthEvent({required this.context});
}

class SwitchAuthPageEvent extends AuthEvent {
  final AuthPage authPage;
  SwitchAuthPageEvent({required this.authPage});
}

class CheckAuthEvent extends AuthEvent {}
