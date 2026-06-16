import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/navigation/go_router_refresh_stream.dart';
import 'package:mybend/features/babel/babel_screen.dart';
import 'package:mybend/features/home/home_screen.dart';
import 'package:mybend/features/signup/signup_screen.dart';
import 'package:mybend/features/todo/todo_screen.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/features/alexandrie/alexandrie_screen.dart';

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
          path: '/todo',
          builder: (context, state) => const TodoScreen(),
        ),
        GoRoute(
          path: '/babel',
          builder: (context, state) => const BabelScreen(),
      
        ),
        GoRoute(
          path: '/alexandrie',
          builder: (context, state) => const AlexandrieScreen(),
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
      case const Initial():
      case const Loading():
        return location == '/splash' ? null : '/splash';
      case const Loaded(false):
        return location == '/login' ? null : '/login';
      case const Loaded(true):
        if (location == '/login' || location == '/splash') {
          return '/home';
        }
        return null;
      default:
        return '/splash';
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
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
