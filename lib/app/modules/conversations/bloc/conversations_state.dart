part of '../index.dart';

enum ConversationsStatus { loading, loaded, init }

ConversationsState roomInitialState = ConversationsState(
  loading: false,
  conversations: [],
);

class ConversationsState {
  final bool loading;
  final List<Conversation> conversations;

  ConversationsState({
    required this.loading,
    required this.conversations,
  });

  ConversationsState copyWith({
    bool? loading,
    List<Conversation>? conversations,
  }) {
    return ConversationsState(
      loading: loading ?? this.loading,
      conversations: conversations ?? this.conversations,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['loading'] = loading;
    data['conversations'] = conversations;
    return data;
  }
}
