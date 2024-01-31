part of 'lo_to_bloc.dart';

abstract class LotoEvent {}

class InitialEvent extends LotoEvent {}

class ListenCount extends LotoEvent {
  String count;

  ListenCount({required this.count});
}

class ListenUsers extends LotoEvent {
  String users;

  ListenUsers({required this.users});
}

class UpdateUserName extends LotoEvent {
  String userName;

  UpdateUserName({required this.userName});
}

class UpdateCouter extends LotoEvent {
  int counter;

  UpdateCouter({required this.counter});
}

class LoadingEvent extends LotoEvent {}
