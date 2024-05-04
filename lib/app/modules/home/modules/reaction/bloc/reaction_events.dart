part of 'reaction_bloc.dart';

abstract class ReactionEvent {}

class InitialReactionEvent extends ReactionEvent {}

class IncrementReactionEvent extends ReactionEvent {
  final String idPost;
  final String reactName;

  IncrementReactionEvent({required this.idPost, required this.reactName});
}

class DecrementReactionEvent extends ReactionEvent {
  final String idPost;
  final String reactName;

  DecrementReactionEvent({required this.idPost, required this.reactName});
}
