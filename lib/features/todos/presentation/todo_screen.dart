import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/settings');
          },
          child: const Text('Go to Settings'),
        ),
      ),
    );
  }
}