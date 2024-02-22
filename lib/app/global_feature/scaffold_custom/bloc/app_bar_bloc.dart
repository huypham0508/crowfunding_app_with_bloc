import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'app_bar_events.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(appBarInitialState) {
    on<ChangeStatusAppBarEvent>(_changeStatus);
    on<SubmitSearchAppBarEvent>(_submitSearch);
  }

  _submitSearch(
    SubmitSearchAppBarEvent event,
    Emitter<AppBarState> emit,
  ) async {
    emit(state.copyWith(searchDynamicStatus: SearchDynamicStatus.loading));
    await Future.delayed(1000.milliseconds);
    emit(state.copyWith(
      searchResults: ['123'],
      searchDynamicStatus: SearchDynamicStatus.nothing,
      status: AppBarStatus.searching,
    ));
  }

  _changeStatus(ChangeStatusAppBarEvent event, Emitter<AppBarState> emit) {
    if (event.status == AppBarStatus.initial) {
      state.focusNode.unfocus();
    }
    emit(state.copyWith(
      status: event.status,
    ));
  }
}
