part of 'friend_bloc.dart';

abstract class FriendEvent {}

class InitialFriendEvent extends FriendEvent {}

class GetFriendsEvent extends FriendEvent {}

class GetFriendsRequestEvent extends FriendEvent {}

class RejectRequestEvent extends FriendEvent {
  final String requestId;
  RejectRequestEvent({required this.requestId});
}

class AcceptRequestEvent extends FriendEvent {
  final String requestId;
  AcceptRequestEvent({required this.requestId});
}
