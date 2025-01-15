part of '../index.dart';

abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class ChangeTabHomeEvent extends HomeEvent {
  final int index;
  final bool gesture;
  ChangeTabHomeEvent({required this.index, this.gesture = false});
}

class JumpToPage extends HomeEvent {
  final int index;
  JumpToPage({required this.index});
}

class GetAllPosts extends HomeEvent {
  final int? pageNumber;
  GetAllPosts({this.pageNumber});
}

class GetPostsYourFriend extends HomeEvent {
  final int? pageNumber;
  GetPostsYourFriend({this.pageNumber});
}

class GetYourPosts extends HomeEvent {
  final int? pageNumber;
  GetYourPosts({this.pageNumber});
}
