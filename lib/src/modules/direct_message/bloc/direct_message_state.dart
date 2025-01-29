part of '../index.dart';

DirectMessageState initStateDirectMessage = DirectMessageState(status: DirectMessageStatus.loading);

enum DirectMessageStatus { loading, loaded, error }

final class DirectMessageState {
  final DirectMessageStatus status;

  DirectMessageState({
    this.status = DirectMessageStatus.loading
  });

  DirectMessageState copyWith({
    DirectMessageStatus? status
  }) {
    return DirectMessageState(
      status: status ?? this.status,
    );
  }
}

