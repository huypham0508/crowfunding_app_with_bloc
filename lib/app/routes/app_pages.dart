import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/views/auth_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/views/home_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/views/lo_to_view.dart';
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
          builder: (context, state) => AuthView(),
        ),
        GoRoute(
          name: 'loto',
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          name: 'home',
          path: Routes.HOME,
          builder: (context, state) => const HomeView(),
        ),
      ],
      redirect: (context, state) async {
        var checkToken = await context.read<LocalDataSource>().getToken();
        if (checkToken != null) {
          return Routes.HOME;
        }
        return Routes.AUTH;
      },
    );
    return router;
  }
}
