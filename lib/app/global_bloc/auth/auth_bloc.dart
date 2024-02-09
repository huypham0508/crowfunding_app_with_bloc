import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_ql_string.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_dto.dart';
import 'package:crowfunding_app_with_bloc/app/models/login_response_dto.dart';
import 'package:crowfunding_app_with_bloc/app/models/register_response.dto.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'auth_events.dart';
part 'auth_state.dart';
part '../../data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalDataSource localDataSource;

  AuthBloc({
    required this.localDataSource,
  }) : super(authInitialState) {
    on<InitialAuthEvent>(_initial);
    on<SwitchAuthPageEvent>(_switchAuthPage);
  }

  void _initial(InitialAuthEvent event, Emitter<AuthState> emit) async {
    var checkToken = await localDataSource.getToken();
    await Future.delayed(500.milliseconds);
    if (checkToken != null) {
      emit(state.copyWith(status: AuthStatus.loginSuccess));
    }
    if (checkToken == null) {
      emit(state.copyWith(authPage: AuthPage.signIn));
    }
  }

  void _switchAuthPage(SwitchAuthPageEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(authPage: event.authPage));
  }
}
