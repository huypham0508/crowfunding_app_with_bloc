import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/forgot_password/models/forgot_password_response.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/models/login_response_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/models/register_response.model.dart';
import 'package:flutter_animate/flutter_animate.dart';

part '../../data/repository/graphql/auth_repository.dart';
part 'auth_events.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalDataSource localDataSource;
  final AuthRepository authRepository;

  AuthBloc({
    required this.localDataSource,
    required this.authRepository,
  }) : super(authInitialState) {
    on<InitialAuthEvent>(_initial);
    on<SwitchAuthPageEvent>(_switchAuthPage);
    on<CheckAuthEvent>(_checkAuth);
    on<SignOutEvent>(_signOut);
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

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await localDataSource.deleteToken();
    await localDataSource.deleteRefreshToken();
    await localDataSource.deleteUserName();
    await localDataSource.deleteUserId();
    await authRepository.logout();
    emit(state.copyWith(
      authPage: AuthPage.signIn,
      status: AuthStatus.signOut,
    ));
  }

  void _switchAuthPage(SwitchAuthPageEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(authPage: event.authPage));
  }
}
