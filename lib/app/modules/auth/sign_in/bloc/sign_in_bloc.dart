import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

part 'sign_in_events.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({
    required this.authRepository,
  }) : super(signInInitialState) {
    on<StartedLoginEvent>(_login);
  }

  void _login(StartedLoginEvent event, Emitter<SignInState> emit) async {
    String? valueValidation = event.validate();
    if (valueValidation.runtimeType == String) {
      emit(state.copyWith(errorMessage: valueValidation));
    }

    if (valueValidation == null) {
      emit(state.copyWith(status: SignInStatus.loading, errorMessage: ''));
      final result = await authRepository.login(event.loginModel);
      if (result.success == true) {
        emit(state.copyWith(status: SignInStatus.loginSuccess));
      } else {
        emit(state.copyWith(
          status: SignInStatus.loginFailure,
          errorMessage: result.message,
        ));
      }
      await _backDialog(emit);
    }
  }

  Future _backDialog(Emitter<SignInState> emit) async {
    emit(state.copyWith(status: SignInStatus.backDialog));
  }
}
