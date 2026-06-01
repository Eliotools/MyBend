import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/signup/signup_screen.dart';

class AppRouter {
  AppRouter(this.authCubit);

  final AuthCubit authCubit;

  GoRouter get router => GoRouter(
        initialLocation: '/splash',
        redirect: (context, state) {
          final authStatus = authCubit.state;
          switch (authStatus) {
            case AuthState.initial:
              return '/splash';
            case AuthState.signedIn:
              return '/home';
            case AuthState.signUp:
              return '/login';
            default:
              return null;
          }
        },
        routes: [
          GoRoute(
            path: '/splash',
            builder: (context, state) => const TmpPage(title: 'Splash'),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const SignupScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const TmpPage(title: 'Home'),
          ),
        ],
      );
}

class TmpPage extends StatelessWidget {
  const TmpPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Text(title,
          style: AppTheme.textTheme.titleMedium?.copyWith(color: Colors.white)),
    );
  }
}
