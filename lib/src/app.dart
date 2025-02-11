import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    initLocalStorage();
    final _navigatorKey = GlobalKey<NavigatorState>();
    late final GoRouter _router = AppRouter.router(_navigatorKey);
    return BlocProvider<LocalStorageBloc>(
      create: (context) => LocalStorageBloc()..getItems(),
      child: SafeArea(
        child: MaterialApp.router(
          restorationScopeId: 'app',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Color.fromARGB(255, 255, 255, 255),
              secondary: Color(0xFF2D2C2C),
              brightness: Brightness.dark,
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSecondary: Color.fromARGB(255, 255, 255, 255),
              error: Colors.red,
              onError: Colors.red,
              surface: Color(0xFF1C1B1B),
              onSurface: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          routerDelegate: _router.routerDelegate,
        ),
      ),
    );
  }
}
