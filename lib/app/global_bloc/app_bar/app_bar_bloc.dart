import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'app_bar_events.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(appBarInitialState) {
    on<ChangeStatusAppBarEvent>(_changeStatus);
  }

  _changeStatus(ChangeStatusAppBarEvent event, Emitter<AppBarState> emit) {
    emit(state.copyWith(
      status: event.status,
    ));
  }
}
