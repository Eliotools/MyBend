import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/features/activity/activity_page.dart';
import 'package:mybend/src/features/history/history_page.dart';
import 'package:mybend/src/features/home/home_screen.dart';
import 'package:mybend/src/features/settings/settings_screen.dart';
import 'package:mybend/src/model/activity.dart';

class AppRouter {
  /// Default transition for all pages

  static Page<void> fadingTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      CustomTransitionPage<void>(
        transitionDuration: const Duration(milliseconds: 600),
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );

  /// Disable transition animation
  static Page<void> noTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (_, __, ___, child) => child,
        child: Scaffold(
          body: child,
        ),
      );

  static GoRouter router(
    GlobalKey<NavigatorState>? navigatorKey,
  ) =>
      GoRouter(
        navigatorKey: navigatorKey,
        routes: [
          GoRoute(
            name: HomePage.name,
            path: '/',
            pageBuilder: (context, state) => noTransition(
              context,
              state,
              const HomePage(),
            ),
          ),
          GoRoute(
            name: ActivityPage.name,
            path: '/${ActivityPage.name}',
            pageBuilder: (context, state) => noTransition(
              context,
              state,
              ActivityPage(activities: state.extra as List<Activity>? ?? []),
            ),
          ),
          GoRoute(
            name: HistoryScreen.name,
            path: '/${HistoryScreen.name}',
            pageBuilder: (context, state) => noTransition(
              context,
              state,
              const HistoryScreen(),
            ),
          ),
          GoRoute(
            name: SettingsPage.name,
            path: '/${SettingsPage.name}',
            pageBuilder: (context, state) => noTransition(
              context,
              state,
              const SettingsPage(),
            ),
          ),
        ],
      );
}
