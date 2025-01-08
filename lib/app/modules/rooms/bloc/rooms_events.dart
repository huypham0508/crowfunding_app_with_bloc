part of 'rooms_bloc.dart';

abstract class RoomsEvent {}

class InitialRoomsEvent extends RoomsEvent {}

class ChangeTabHomeEvent extends RoomsEvent {
  final int index;
  final bool gesture;
  ChangeTabHomeEvent({required this.index, this.gesture = false});
}

class JumpToPage extends RoomsEvent {
  final int index;
  JumpToPage({required this.index});
}

class GetAllPosts extends RoomsEvent {
  final int? pageNumber;
  GetAllPosts({this.pageNumber});
}

class GetPostsYourFriend extends RoomsEvent {
  final int? pageNumber;
  GetPostsYourFriend({this.pageNumber});
}

class GetYourPosts extends RoomsEvent {
  final int? pageNumber;
  GetYourPosts({this.pageNumber});
}
