part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class ChangeTabHomeEvent extends HomeEvent {
  final int index;
  ChangeTabHomeEvent({required this.index});
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
