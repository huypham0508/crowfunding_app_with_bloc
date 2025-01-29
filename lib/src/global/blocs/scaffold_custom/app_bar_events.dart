part of 'app_bar_bloc.dart';

abstract class AppBarEvent {}

class InitialAppBarEvent extends AppBarEvent {}

class ChangeStatusAppBarEvent extends AppBarEvent {
  ChangeStatusAppBarEvent({required this.status});
  final AppBarStatus status;
}

class SubmitSearchAppBarEvent extends AppBarEvent {}

class OnTapFriendAppBarEvent extends AppBarEvent {
  final FriendResult friendResult;

  OnTapFriendAppBarEvent({required this.friendResult});
}

class WipeLeftToRightAppBarEvent extends AppBarEvent {
  final double wipeDx;
  WipeLeftToRightAppBarEvent({
    required this.wipeDx,
  });
}

class WipeScaffoldStartAppBarEvent extends AppBarEvent {
  final double position;
  WipeScaffoldStartAppBarEvent({required this.position});
}

class WipeScaffoldEndAppBarEvent extends AppBarEvent {
  WipeScaffoldEndAppBarEvent();
}
