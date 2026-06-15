import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/core/navigation/router.dart';
import 'package:mybend/core/theme/theme_cubit.dart';
import 'package:mybend/core/themes/dark_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final AuthCubit _authCubit = getIt<AuthCubit>();
  final ThemeCubit _themeCubit = getIt<ThemeCubit>();
  late final GoRouter _router = AppRouter(_authCubit).router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _themeCubit,
      child: BlocBuilder<ThemeCubit, String>(
        builder: (context, themeKey) => MaterialApp.router(
          routerConfig: _router,
          theme: colorMap[themeKey] ?? darkTheme,
        ),
      ),
    );
  }
}
