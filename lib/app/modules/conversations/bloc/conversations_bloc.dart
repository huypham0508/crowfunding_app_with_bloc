part of '../index.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationRepository conversationRepository;
  Map<String, Timer> typingTimers = {};

  ConversationsBloc({
    required this.conversationRepository,
  }) : super(roomInitialState) {
    on<InitialConversationsEvent>(_initial);
    on<StartedTypingEvent>(_startedTyping);
    on<CancelTypingEvent>(_cancelTyping);
  }

  void _initial(
    InitialConversationsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));
      final response = await conversationRepository.getAllConversations();
      if (response.success == true) {
        final conversationStates = response.conversations.map((conversation) {
          return Conversation(
            id: conversation.id,
            name: conversation.name,
            participants: conversation.participants,
            maxMessage: conversation.maxMessage,
          );
        }).toList();
        emit(state.copyWith(
          conversations: conversationStates,
          loading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _startedTyping(
    StartedTypingEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    _handleChangeTyping(emit, event: event.userTyping, value: true);
  }

  void _cancelTyping(
    CancelTypingEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    _handleChangeTyping(emit, event: event.userTyping, value: false);
  }

  void _handleChangeTyping(
    Emitter<ConversationsState> emit, {
    required UserTyping event,
    required bool value,
  }) async {
    final index = state.conversations.indexWhere(
      (conversation) => conversation.id == event.roomId,
    );

    if (index != -1) {
      typingTimers[event.roomId]?.cancel();
      state.conversations[index] = Conversation(
        id: state.conversations[index].id,
        name: state.conversations[index].name,
        participants: state.conversations[index].participants,
        maxMessage: state.conversations[index].maxMessage,
        isTyping: value,
      );
      emit(state.copyWith());
      if (value) {
        typingTimers[event.roomId] = Timer(
          Duration(seconds: 3),
          () => add(CancelTypingEvent(userTyping: event)),
        );
      }
    }
  }
}
