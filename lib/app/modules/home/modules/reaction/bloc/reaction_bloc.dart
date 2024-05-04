import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/graphql_response_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/reaction/models/reaction_response.dart';
import 'package:rxdart/rxdart.dart';

part '../repository/reaction_repository.dart';
part 'reaction_events.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  final ReactionRepository reactionRepository;

  ReactionBloc({
    required this.reactionRepository,
  }) : super(reactionInitialState) {
    on<InitialReactionEvent>(_initial);
    on<IncrementReactionEvent>(
      _increment,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
    on<DecrementReactionEvent>(
      _decrement,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  void _initial(InitialReactionEvent event, Emitter<ReactionState> emit) async {
    try {
      final result = await reactionRepository.getReactions();
      if (result.success == true) {
        if (result.data != null) {
          return emit(state.copyWith(
            status: ReactionStatus.success,
            reactions: result.data,
          ));
        }
      }
      emit(state.copyWith(status: ReactionStatus.failed));
    } catch (error) {
      emit(state.copyWith(status: ReactionStatus.failed));
    }
  }

  void _increment(
    IncrementReactionEvent event,
    Emitter<ReactionState> emit,
  ) async {
    await reactionRepository.increment(event.idPost, event.reactName);
  }

  void _decrement(
    DecrementReactionEvent event,
    Emitter<ReactionState> emit,
  ) async {
    await reactionRepository.decrement(event.idPost, event.reactName);
  }
}
