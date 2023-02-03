import 'package:flutter/material.dart';
import 'package:go_router_example/router/router.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NavigationItems.tabs.routes.length,
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.blue,
            child: const Text('Tab Screen'),
          ),
          bottom: TabBar(
            onTap: (int idx) {
              final element = NavigationItems.values.firstWhere(
                (e) => e.index == idx,
              );

              print(element.toString());

              // _selectedIndex.value = idx;
              // context.go(element.path);
            },
            tabs: NavigationItems.values.map((e) {
              return Tab(icon: Icon(e.iconData));
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: NavigationItems.values.map((e) {
            return Icon(e.iconData);
          }).toList(),
        ),
      ),
    );
  }
}
