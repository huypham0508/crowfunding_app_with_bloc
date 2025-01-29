part of '../../../index.dart';

class FriendRepository {
  final GraphQlAPIClient graphQLClient;

  FriendRepository({required this.graphQLClient});

  Future<ListFriendResponse> getFriends() async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getFriendsQuery,
    );
    if (result == null) {
      throw ApiException();
    }

    return ListFriendResponse.fromJson(result['getFriendList']);
  }

  Future<ListFriendResponse> getFriendsRequest() async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getFriendsRequestQuery,
    );
    if (result == null) {
      throw ApiException();
    }

    return ListFriendResponse.fromJson(result['getFriendRequests']);
  }

  Future<GraphQlResponse> sendFriendRequest(String? friendId) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.sendFriendRequestMutation,
      variables: {"friendId": friendId},
    );

    if (result == null) {
      throw ApiException();
    }
    return GraphQlResponse.fromJson(result['sendFriendRequest']);
  }

  Future<GraphQlResponse> rejectedRequest(String? requestId) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.rejectedRequestMutation,
      variables: {"requestId": requestId},
    );

    if (result == null) {
      throw ApiException();
    }

    return GraphQlResponse.fromJson(result['rejectedFriendRequest']);
  }

  Future<GraphQlResponse> acceptRequest(String? requestId) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.acceptRequestMutation,
      variables: {"requestId": requestId},
    );

    if (result == null) {
      throw ApiException();
    }

    return GraphQlResponse.fromJson(result['acceptFriendRequest']);
  }
}
