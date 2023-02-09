import 'package:flutter/material.dart'
    show
        BuildContext,
        IconData,
        Icons,
        Scaffold,
        SizedBox,
        Text,
        ValueKey,
        Widget;
import 'package:go_router/go_router.dart';
import 'package:go_router_example/app_scaffold.dart';
import 'package:go_router_example/home_screen.dart';
import 'package:go_router_example/router/transitions/fade_transition_page.dart';

import 'package:go_router_example/user_screen.dart';

/// Router
class Routes {
  Routes._();

  static const _initialLocation = '/';

  /// Keys
  static const ValueKey<String> _scaffoldKey = ValueKey<String>('App scaffold');

  /// Router instance
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: _initialLocation,
    routes: [..._redirects, ..._directNavigations, ..._nestedNavigations],
    errorBuilder: (_, __) => const Text('404'),
  );

  /// defines which routes are supposed to be accessible without sign-in tokens.
  // static final _publicRoutes = <String>[];

  /// defines'root' route. routes that are un-related such as login to home.
  static final _directNavigations = <GoRoute>[];

  static final _redirects = <GoRoute>[
    // GoRoute(path: '/', redirect: (_, __) => '/d/home'),
  ];

  /// defines sub-routes, usefull for when we need to render a dialog, tab etc
  static final _nestedNavigations = <ShellRoute>[
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(
          key: _scaffoldKey,
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: DashboardItems.home.item.name,
          path: DashboardItems.home.item.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return FadeTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          name: DashboardItems.users.item.name,
          path: DashboardItems.users.item.path,
          pageBuilder: (_, GoRouterState state) {
            return FadeTransitionPage(
              key: state.pageKey,
              child: const UserScreen(),
            );
          },
        ),
        // GoRoute(
        //   path: '/d',
        //   builder: (_, __) => const Scaffold(),
        //   routes: [

        //   ],
        // ),
      ],
    ),
  ];
}
