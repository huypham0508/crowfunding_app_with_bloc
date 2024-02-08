import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_ql_string.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:crowfunding_app_with_bloc/app/models/login_response_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

part 'auth_events.dart';
part 'auth_repository.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final LocalDataSource localDataSource;

  AuthBloc({
    required this.authRepository,
    required this.localDataSource,
  }) : super(authInitialState) {
    on<InitialAuthEvent>(_initial);
    on<StartedLoginAuthEvent>(_login);
    on<SwitchAuthPageEvent>(_switchAuthPage);
  }

  void _initial(InitialAuthEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(700.milliseconds);
    var checkToken = await localDataSource.getToken();
    await Future.delayed(500.milliseconds);
    if (checkToken != null) {
      emit(state.copyWith(status: AuthStatus.loginSuccess));
    }
    if (checkToken == null) {
      emit(state.copyWith(authPage: AuthPage.signIn));
    }
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

  void _switchAuthPage(SwitchAuthPageEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(authPage: event.authPage, errorMessage: ''));
  }

  Future _backDialog(Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(status: AuthStatus.backDialog));
  }
}
