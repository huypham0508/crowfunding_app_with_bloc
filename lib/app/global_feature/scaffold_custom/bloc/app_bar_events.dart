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

class WipeScaffoldAppBarEvent extends AppBarEvent {
  final double wipeDx;
  WipeScaffoldAppBarEvent({
    required this.wipeDx,
  });
}

class WipeScaffoldEndAppBarEvent extends AppBarEvent {
  WipeScaffoldEndAppBarEvent();
}
