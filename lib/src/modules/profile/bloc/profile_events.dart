part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class InitialProfileEvent extends ProfileEvent {}

class ChangeProfileImageEvent extends ProfileEvent {
  final String image;
  ChangeProfileImageEvent({required this.image});
}
