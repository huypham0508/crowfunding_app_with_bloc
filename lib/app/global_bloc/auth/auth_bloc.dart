import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/models/login_response_model.dart';
import 'package:crowfunding_app_with_bloc/app/models/register_response.model.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'auth_events.dart';
part 'auth_state.dart';
part '../../data/repository/graphql/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalDataSource localDataSource;

  AuthBloc({
    required this.localDataSource,
  }) : super(authInitialState) {
    on<InitialAuthEvent>(_initial);
    on<SwitchAuthPageEvent>(_switchAuthPage);
    on<CheckAuthEvent>(_checkAuth);
  }

  void _initial(InitialAuthEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(1500.milliseconds);
    add(CheckAuthEvent());
  }

  void _checkAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    // localDataSource.deleteToken();
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
