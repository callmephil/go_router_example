import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/router/router.dart';

// enum Routes {
//   someroute,
// }

// class MyObject {}

// Map<Routes, MyObject> listroutes = {
//   Routes.someroute: MyObject(),
// };

// listroutes[Routes.name];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        color: Colors.red,
        child: ElevatedButton(
          onPressed: () {
            context.go(NavigationItems.direct.path);
          },
          child: const Text("Don't press Me"),
        ),
      ),
    );
  }
}
