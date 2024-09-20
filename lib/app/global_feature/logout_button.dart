import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.signOut:
            context.go(RoutePaths.AUTH);
            break;
          default:
        }
      },
      child: IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(SignOutEvent());
        },
        icon: Icon(Icons.logout_outlined),
      ),
    );
  }
}
