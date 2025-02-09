import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    late final GoRouter _router = AppRouter.router(_navigatorKey);
    return SafeArea(
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
    );
    
  }
}


