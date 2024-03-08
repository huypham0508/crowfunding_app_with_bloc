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
    on<WipeLeftToRightAppBarEvent>(_wipeScaffoldLeftToRight);
    on<WipeScaffoldEndAppBarEvent>(_wipeScaffoldEnd);
    on<WipeScaffoldStartAppBarEvent>(_wipeScaffoldStart);
  }
  _changeStatus(
    ChangeStatusAppBarEvent event,
    Emitter<AppBarState> emit,
  ) async {
    // print(object);
    emit(
      state.copyWith(
        status: event.status,
        hiddenSearchResults: event.status == AppBarStatus.searching
            ? false
            : state.hiddenSearchResults,
      ),
    );

    if (event.status == AppBarStatus.initial) {
      await Future.delayed(300.milliseconds);
      emit(state.copyWith(hiddenSearchResults: true));
      state.focusNode.unfocus();
    }
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
      hiddenSearchResults: false,
    ));
  }

  _wipeScaffoldLeftToRight(
    WipeLeftToRightAppBarEvent event,
    Emitter<AppBarState> emit,
  ) async {
    if (state.status != AppBarStatus.searching) {
      double drawerW = state.drawerWidth + event.wipeDx;
      if (drawerW > 0) {
        if (drawerW > 150) {
          emit(state.copyWith(
            drawerWidth: 160,
            status: AppBarStatus.showDrawer,
          ));
        } else {
          emit(state.copyWith(
            drawerWidth: drawerW,
            status: AppBarStatus.initial,
          ));
        }
      }
    }
  }

  _wipeScaffoldEnd(
    WipeScaffoldEndAppBarEvent event,
    Emitter<AppBarState> emit,
  ) {
    if (state.status != AppBarStatus.searching) {
      if (state.drawerWidth < 150) {
        emit(state.copyWith(drawerWidth: 0, positionTouches: 0));
      }
    }
  }

  _wipeScaffoldStart(
    WipeScaffoldStartAppBarEvent event,
    Emitter<AppBarState> emit,
  ) {
    print('object');
    if (state.status != AppBarStatus.searching) {
      emit(state.copyWith(positionTouches: event.position));
    }
  }
}
