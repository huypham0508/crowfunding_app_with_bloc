import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/views/auth_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/views/lo_to_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static GoRouter returnRouter(GlobalKey<NavigatorState> navigatorKey) {
    GoRouter router = GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          name: 'auth',
          path: Routes.AUTH,
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(
          name: 'login',
          path: Routes.LOGIN,
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          name: 'loto',
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
      ],
      redirect: (context, state) async {
        var checkAuth = context.read<AuthBloc>().state.status;
        if (checkAuth == AuthStatus.loginSuccess) {
          return Routes.LOTO;
        }
        return Routes.AUTH;
      },
    );
    return router;
  }
}
