import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    if (valueValidation.runtimeType == String) {
      emit(state.copyWith(errorMessage: valueValidation));
    }

    if (valueValidation == null) {
      emit(state.copyWith(status: SignUpStatus.loading, errorMessage: ''));
      final result = await authRepository.register(event.registerModel);
      print(result.message);
      await _backDialog(emit);
      if (result.success == true) {
        emit(state.copyWith(status: SignUpStatus.registerSuccess));
      } else {
        emit(state.copyWith(
          status: SignUpStatus.registerFailure,
          errorMessage: result.message,
        ));
      }
    }
  }

  Future _backDialog(Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.backDialog));
  }
}
