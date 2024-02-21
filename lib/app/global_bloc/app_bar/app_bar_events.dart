part of 'app_bar_bloc.dart';

abstract class AppBarEvent {}

class InitialAppBarEvent extends AppBarEvent {}

class ChangeStatusAppBarEvent extends AppBarEvent {
  ChangeStatusAppBarEvent({required this.status});
  final AppBarStatus status;
}
