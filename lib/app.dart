import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/core/navigation/router.dart';
import 'package:mybend/core/themes/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final AuthCubit _authCubit = getIt<AuthCubit>();
  late final GoRouter _router = AppRouter(_authCubit).router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: _router,
        theme: AppTheme.theme,
        darkTheme: AppTheme.theme,
      );
  }
}
