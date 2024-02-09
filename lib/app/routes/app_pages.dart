import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
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
          name: Routes.AUTH,
          path: Routes.AUTH,
          // builder: (context, state) => const AuthView(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const AuthView(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(
                  opacity: CurveTween(
                    curve: Curves.linear,
                  ).animate(
                    animation,
                  ),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          name: Routes.LOTO,
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          name: Routes.HOME,
          path: Routes.HOME,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const HomeView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.linear,
                ).animate(
                  animation,
                ),
                child: child,
              );
            },
          ),
        ),
      ],
      redirect: (context, state) async {
        var checkAuth = context.read<AuthBloc>().state.status;
        if (checkAuth == AuthStatus.loginSuccess) {
          return Routes.HOME;
        }
        return Routes.AUTH;
      },
    );
    return router;
  }
}
