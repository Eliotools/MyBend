import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/navigation/go_router_refresh_stream.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/babel/babel_screen.dart';
import 'package:mybend/features/home/home_screen.dart';
import 'package:mybend/features/signup/signup_screen.dart';

class AppRouter {
  AppRouter(this.authCubit) {
    _router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: _redirect,
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
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/babel',
          builder: (context, state) => const BabelScreen(),
        ),
      ],
    );
  }

  final AuthCubit authCubit;
  late final GoRouter _router;

  GoRouter get router => _router;

  String? _redirect(BuildContext context, GoRouterState state) {
    final authStatus = authCubit.state;
    final location = state.matchedLocation;

    switch (authStatus) {
      case AuthState.initial:
      case AuthState.loading:
        return location == '/splash' ? null : '/splash';
      case AuthState.signUp:
        return location == '/login' ? null : '/login';
      case AuthState.signedIn:
        if (location == '/login' || location == '/splash') {
          return '/home';
        }
        return null;
    }
  }
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
