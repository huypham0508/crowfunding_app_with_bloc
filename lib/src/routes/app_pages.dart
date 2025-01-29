import 'package:crowfunding_app_with_bloc/src/global/blocs/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/modules/auth/index.dart';
import 'package:crowfunding_app_with_bloc/src/modules/direct_message/index.dart';
import 'package:crowfunding_app_with_bloc/src/modules/home/index.dart';
import 'package:crowfunding_app_with_bloc/src/modules/conversations/index.dart';

import 'package:crowfunding_app_with_bloc/src/modules/lo_to/views/lo_to_view.dart';
import 'package:crowfunding_app_with_bloc/src/modules/profile/views/profile_view.dart';
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
              return Paths.CONVERSATIONS;
            }
            return null;
          },
        ),
        GoRoute(
          path: Paths.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          path: Paths.CONVERSATIONS,
          builder: (context, state) => const ConversationsView(),
          routes: [
            GoRoute(
              path: Paths.DIRECT_MESSAGE,
              builder: (context, state) => const DirectMessageView(),
            ),
          ],
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
          ],
        ),
      ],
    );
    return router;
  }
}
