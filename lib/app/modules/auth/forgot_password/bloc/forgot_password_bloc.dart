import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rxdart/rxdart.dart';

part 'forgot_password_events.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordBloc({
    required this.authRepository,
  }) : super(forgotPasswordInitialState) {
    on<StartedForgotPasswordEvent>(
      _forgotPassword,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  void _forgotPassword(
    StartedForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    String? valueValidation = event.validate();
    _emitErrorMessage(emit, valueValidation);

    bool checkType = (event.type == StartedForgotPasswordEventEnum.submitted);
    if (checkType && valueValidation == null) {
      await _processForgotPassword(event, emit);
    }
  }

  void _emitErrorMessage(
    Emitter<ForgotPasswordState> emit,
    String? errorMessage,
  ) {
    emit(state.copyWith(errorMessage: errorMessage ?? ""));
  }

  _processForgotPassword(
    StartedForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    await Future.delayed(1.seconds);
    emit(state.copyWith(
      step: event.step,
      status: ForgotPasswordStatus.backDialog,
    ));
  }

  //local function
  Future _backDialog(Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: ForgotPasswordStatus.backDialog));
  }
}
