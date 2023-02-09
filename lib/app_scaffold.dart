import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/router/router.dart';

class NavigationItem {
  const NavigationItem({
    required this.name,
    required this.path,
    required this.iconData,
  });

  final String name;
  final String path;
  final IconData iconData;
}

enum DashboardItems {
  home(
    NavigationItem(
      name: 'home',
      path: '/d/home',
      iconData: Icons.home,
    ),
  ),
  users(
    NavigationItem(
      name: 'users',
      path: '/d/users',
      iconData: Icons.people,
    ),
  ),
  ;

  const DashboardItems(this.item);
  final NavigationItem item;
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  void didUpdateWidget(AppScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);

    final element = DashboardItems.values.firstWhere(
      (e) => e.item.path == GoRouter.of(context).location,
    );

    _selectedIndex.value = element.index;
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, value, ___) {
          return AdaptiveNavigationScaffold(
            selectedIndex: value,
            body: widget.child,
            onDestinationSelected: (int idx) {
              final element = DashboardItems.values.firstWhere(
                (e) => e.index == idx,
              );

              // _selectedIndex.value = idx;
              context.go(element.item.path);
              // print(element.path);
            },
            destinations: DashboardItems.values.map((e) {
              return AdaptiveScaffoldDestination(
                title: e.item.name,
                icon: e.item.iconData,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
