import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_ql_string.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:crowfunding_app_with_bloc/app/models/login_response_dto.dart';
import 'package:flutter/material.dart';

part 'auth_events.dart';
part 'auth_repository.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(authInitialState) {
    on<StartedLoginAuthEvent>(_login);
  }

  void _login(StartedLoginAuthEvent event, Emitter<AuthState> emit) async {
    String? valueValidation = event.validate();
    if (valueValidation.runtimeType == String) {
      emit(state.copyWith(errorMessage: valueValidation));
    }

    if (valueValidation == null) {
      emit(state.copyWith(status: AuthStatus.loading, errorMessage: ''));
      final result = await authRepository.login(event.loginModel);
      await _backDialog(emit);
      if (result.success == true) {
        emit(state.copyWith(status: AuthStatus.loginSuccess));
      } else {
        emit(state.copyWith(
          status: AuthStatus.loginFailure,
          errorMessage: result.message,
        ));
      }
    }
  }

  Future _backDialog(Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(status: AuthStatus.backDialog));
  }
}
