part of '../index.dart';

abstract class ConversationsEvent {}

class InitialConversationsEvent extends ConversationsEvent {}

class StartedTypingEvent extends ConversationsEvent {
  final UserTyping userTyping;
  StartedTypingEvent({required this.userTyping});
}

class CancelTypingEvent extends ConversationsEvent {
  final UserTyping userTyping;
  CancelTypingEvent({required this.userTyping});
}
