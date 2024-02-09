part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {}

class SwitchAuthPageEvent extends AuthEvent {
  final AuthPage authPage;
  SwitchAuthPageEvent({required this.authPage});
}
