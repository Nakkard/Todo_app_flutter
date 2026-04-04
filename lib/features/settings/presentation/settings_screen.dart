import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go(AppRoutes.todos);
          },
          child: const Text('Go to Todos'),
        ),
      ),
    );
  }
}