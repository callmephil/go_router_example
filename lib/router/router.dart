import 'package:flutter/material.dart'
    show BuildContext, IconData, Icons, SizedBox, Text, ValueKey, Widget;
import 'package:go_router/go_router.dart';
import 'package:go_router_example/app_scaffold.dart';
import 'package:go_router_example/home_screen.dart';
import 'package:go_router_example/router/transitions/fade_transition_page.dart';
import 'package:go_router_example/tab_screen.dart';

// enum TabNavigation {
//   car(iconData: Icons.directions_car, path: '/tabs/cars', name: "cars"),
//   transit(
//     iconData: Icons.directions_transit,
//     path: '/tabs/transit',
//     name: "transit",
//   ),
//   bike(iconData: Icons.directions_bike, path: '/tabs/transit', name: "transit");

//   const TabNavigation({
//     required this.iconData,
//     required this.path,
//     required this.name,
//   });

//   final IconData iconData;
//   final String path;
//   final String name;
// }

enum NavigationItems {
  home(
    path: "/home",
    name: "home",
    iconData: Icons.home,
    screen: HomeScreen(),
  ),
  direct(
    path: "/direct",
    name: "direct",
    iconData: Icons.directions_outlined,
    screen: HomeScreen(),
  ),
  tabs(
    path: '/tabs/:kind(cars|transit|bike)',
    name: "tabs",
    iconData: Icons.tab_unselected_rounded,
    screen: TabScreen(),
    routes: [
      NavigationItem(
        iconData: Icons.directions_car,
        path: '/cars',
        name: "cars",
      ),
      NavigationItem(
        iconData: Icons.directions_transit,
        path: '/transit',
        name: "transit",
      ),
      NavigationItem(
        iconData: Icons.directions_bike,
        path: '/bike',
        name: "bike",
      ),
    ],
  );

  const NavigationItems({
    required this.path,
    required this.name,
    required this.iconData,
    this.screen,
    this.routes = const [],
  });

  final String path;
  final String name;
  final IconData iconData;
  final Widget? screen;
  final List<NavigationItem> routes;

  // String get name => path.substring(path.lastIndexOf('/'));
}

class NavigationItem {
  const NavigationItem({
    required this.path,
    required this.name,
    required this.iconData,
    this.screen,
  });

  final String path;
  final String name;
  final IconData iconData;
  final Widget? screen;
}

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
    GoRoute(path: '/', redirect: (_, __) => '/home'),
    GoRoute(path: '/tabs', redirect: (_, __) => '/tabs/cars'),
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
      routes: NavigationItems.values.map(
        (e) {
          return GoRoute(
            name: e.name,
            path: e.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FadeTransitionPage(
                key: state.pageKey,
                child: e.screen ?? const SizedBox(),
              );
            },
            // routes: e.routes.map((e) {
            //   return GoRoute(
            //     name: e.name,
            //     path: e.path,
            //     // redirect: (_, __) => null,
            //     builder: (_, __) => const Scaffold(),
            //     // pageBuilder: (BuildContext context, GoRouterState state) {
            //     //   return FadeTransitionPage(
            //     //     key: state.pageKey,
            //     //     child: e.screen,
            //     //   );
            //     // },
            //   );
            // }).toList(),
          );
        },
      ).toList(),
    ),
  ];
}
