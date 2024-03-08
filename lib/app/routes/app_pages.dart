import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/views/auth_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/views/home_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/views/lo_to_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/profile/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: RouteChild.AUTH,
          path: Routes.AUTH,
          builder: (context, state) => const AuthView(),
          redirect: (context, state) async {
            var checkAuth = context.read<AuthBloc>().state.status;
            if (checkAuth == AuthStatus.loginSuccess) {
              return Routes.HOME;
            }
            return null;
          },
        ),
        GoRoute(
          name: RouteChild.LOTO,
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          name: RouteChild.HOME,
          path: Routes.HOME,
          builder: (context, state) => const HomeView(),
          redirect: (context, state) async {
            var checkAuth = context.read<AuthBloc>().state.status;
            if (checkAuth != AuthStatus.loginSuccess) {
              return Routes.AUTH;
            }
            return null;
          },
          routes: [
            GoRoute(
              name: RouteChild.PROFILE,
              path: RouteChild.PROFILE,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    );
    return router;
  }
}
