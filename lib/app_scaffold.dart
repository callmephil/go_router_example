import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/router/router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

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
              final element = NavigationItems.values.firstWhere(
                (e) => e.index == idx,
              );

              _selectedIndex.value = idx;
              context.go(element.path);
              // print(element.path);
            },
            destinations: NavigationItems.values.map((e) {
              return AdaptiveScaffoldDestination(
                title: e.name,
                icon: e.iconData,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
