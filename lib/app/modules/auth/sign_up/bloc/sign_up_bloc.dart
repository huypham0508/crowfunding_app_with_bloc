import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/utils/validate.dart';
import 'package:flutter/material.dart';

part 'sign_up_events.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({
    required this.authRepository,
  }) : super(signUpInitialState) {
    on<StartedSignUpEvent>(_register);
  }

  void _register(StartedSignUpEvent event, Emitter<SignUpState> emit) async {
    String? valueValidation = event.validate();
    _emitErrorMessage(emit, valueValidation);

    bool checkType = event.type == StartedSignUpEventEnum.submitted;
    if (checkType && valueValidation == null) {
      await _processRegister(event, emit);
    }
  }

  //local function
  Future _backDialog(Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.backDialog));
  }

  void _emitErrorMessage(Emitter<SignUpState> emit, String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage ?? ""));
  }

  Future<void> _processRegister(
    StartedSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final result = await authRepository.register(event.registerModel);
    await _backDialog(emit);
    if (result.success == true) {
      emit(state.copyWith(status: SignUpStatus.registerSuccess));
    } else {
      emit(state.copyWith(
        status: SignUpStatus.registerFailure,
        errorMessage: result.message,
      ));
    }
    await _backDialog(emit);
  }
}
