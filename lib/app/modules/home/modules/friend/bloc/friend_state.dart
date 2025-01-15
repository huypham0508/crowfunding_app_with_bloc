part of '../../../index.dart';

FriendState authInitialState = const FriendState(
  status: FriendStatus.loading,
  friends: [],
  friendsRequest: [],
);

enum FriendStatus { loading, loaded, loadFailed }

class FriendState {
  final FriendStatus status;
  final List<FriendModel> friends;
  final List<FriendModel> friendsRequest;
  const FriendState({
    required this.status,
    required this.friends,
    required this.friendsRequest,
  });

  FriendState copyWith({
    FriendStatus? status,
    List<FriendModel>? friends,
    List<FriendModel>? friendsRequest,
  }) {
    return FriendState(
      status: status ?? this.status,
      friends: friends ?? this.friends,
      friendsRequest: friendsRequest ?? this.friendsRequest,
    );
  }
}
