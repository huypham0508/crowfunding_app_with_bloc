import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/views/auth_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/views/home_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/views/lo_to_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/messages/views/messages_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/profile/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: Paths.AUTH,
          builder: (context, state) => const AuthView(),
          redirect: (context, state) async {
            var checkAuth = context.read<AuthBloc>().state.status;
            if (checkAuth == AuthStatus.loginSuccess) {
              return Paths.HOME;
            }
            return null;
          },
        ),
        GoRoute(
          path: Paths.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          path: Paths.HOME,
          builder: (context, state) => const HomeView(),
          redirect: (context, state) async {
            var checkAuth = context.read<AuthBloc>().state.status;
            if (checkAuth != AuthStatus.loginSuccess) {
              return Paths.AUTH;
            }
            return null;
          },
          routes: [
            GoRoute(
              path: Paths.PROFILE,
              builder: (context, state) => const ProfileView(),
            ),
            GoRoute(
              path: Paths.MESSAGES,
              builder: (context, state) => const MessagesView(),
            ),
          ],
        ),
      ],
    );
    return router;
  }
}
