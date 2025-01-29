part of '../index.dart';

enum ConversationsStatus { loading, loaded, init }

ConversationsState conversationInitialState = ConversationsState(
  status: ConversationsStatus.init,
  conversations: [],
);

class ConversationsState {
  final ConversationsStatus status;
  final List<Conversation> conversations;

  ConversationsState({
    required this.status,
    required this.conversations,
  });

  ConversationsState copyWith({
    ConversationsStatus? status,
    List<Conversation>? conversations,
  }) {
    return ConversationsState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['conversations'] = conversations;
    return data;
  }
}
