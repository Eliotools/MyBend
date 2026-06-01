import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/core/navigation/router.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/signup/signup_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()),
        BlocProvider.value(value: getIt<SignupCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter(getIt<AuthCubit>()).router,
        theme: AppTheme.theme,
        darkTheme: AppTheme.theme,
      ),
    );
  }
}
