part of '../index.dart';

class ConversationRepository {
  final GraphQlAPIClient graphQLClient;

  ConversationRepository({
    required this.graphQLClient,
  });

  Future<ConversationsResponse> getAllConversations() async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getAllConversations,
    );
    if (result == null) {
      throw ApiException();
    }

    return ConversationsResponse.fromJson(result['getAllRooms'] ?? '');
  }
}
