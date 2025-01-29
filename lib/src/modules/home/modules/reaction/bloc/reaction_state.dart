part of "../../../index.dart";

ReactionState reactionInitialState = const ReactionState(
  status: ReactionStatus.loading,
  reactions: [],
);

enum ReactionStatus { loading, failed, success }

class ReactionState {
  final ReactionStatus status;
  final List<ReactionModel> reactions;
  const ReactionState({
    required this.status,
    required this.reactions,
  });

  ReactionState copyWith({
    ReactionStatus? status,
    List<ReactionModel>? reactions,
  }) {
    return ReactionState(
      status: status ?? this.status,
      reactions: reactions ?? this.reactions,
    );
  }
}
