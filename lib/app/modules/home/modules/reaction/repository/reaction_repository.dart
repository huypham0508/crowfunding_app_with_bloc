part of "../../../index.dart";

class ReactionRepository {
  final GraphQlAPIClient graphQLClient;

  ReactionRepository({required this.graphQLClient});

  Future<ReactionResponse> getReactions() async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getReactionsQuery,
    );
    if (result == null) {
      throw ApiException();
    }

    return ReactionResponse.fromJson(result['reactions']);
  }

  Future<GraphQlResponse> increment(String idPost, String reactName) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.incrementMutation,
      variables: {
        "reactName": reactName,
        "postId": idPost,
      },
    );
    if (result == null) {
      throw ApiException();
    }

    return GraphQlResponse.fromJson(result['increaseReactionCount']);
  }

  Future<GraphQlResponse> decrement(String idPost, String reactName) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.decrementMutation,
      variables: {
        "reactName": reactName,
        "postId": idPost,
      },
    );
    if (result == null) {
      throw ApiException();
    }

    return GraphQlResponse.fromJson(result['decreaseReactionCount']);
  }
}
