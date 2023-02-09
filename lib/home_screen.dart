import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/router/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  void increment() {
    if (!mounted) return;

    setState(() {
      counter++;
    });
  }

  void decrement() {
    if (!mounted) return;

    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Text(counter.toString()),
          TextButton(onPressed: increment, child: const Text('Increment')),
          TextButton(onPressed: decrement, child: const Text('Decrement')),
        ],
      ),
    );
  }
}
