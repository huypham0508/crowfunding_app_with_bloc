part of 'app_bar_bloc.dart';

abstract class AppBarEvent {}

class InitialAppBarEvent extends AppBarEvent {}

class ChangeStatusAppBarEvent extends AppBarEvent {
  ChangeStatusAppBarEvent({required this.status});
  final AppBarStatus status;
}

class SubmitSearchAppBarEvent extends AppBarEvent {
  SubmitSearchAppBarEvent();
}

class WipeLeftToRightAppBarEvent extends AppBarEvent {
  final double wipeDx;
  WipeLeftToRightAppBarEvent({
    required this.wipeDx,
  });
}

class WipeScaffoldEndAppBarEvent extends AppBarEvent {
  WipeScaffoldEndAppBarEvent();
}
