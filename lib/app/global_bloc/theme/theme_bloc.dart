import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'theme_events.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalDataSource localDataSource;

  ThemeBloc({
    required this.localDataSource,
  }) : super(authInitialState) {
    on<InitialThemeEvent>(_initial);
    on<SwitchModeThemeEvent>(_switchThemePage);
  }

  void _initial(InitialThemeEvent event, Emitter<ThemeState> emit) async {
    await Future.delayed(1500.milliseconds);
    emit(state.copyWith(status: ThemeStatus.dark));
    localDataSource.saveThemeMode(ThemeStatus.dark.toString());
  }

  void _switchThemePage(SwitchModeThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(status: event.mode));
    localDataSource.saveThemeMode(event.mode.toString());
  }
}
