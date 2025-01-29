part of '../index.dart';

class DirectMessageBloc extends Bloc<DirectMessageEvent, DirectMessageState> {
  final DirectMessageRepository directMessageRepository;

  DirectMessageBloc({required this.directMessageRepository}) : super(initStateDirectMessage) {
    on<InitDirectMessageEvent>(_init);
  }

  _init(InitDirectMessageEvent event, Emitter<DirectMessageState> emit) async {}
}

