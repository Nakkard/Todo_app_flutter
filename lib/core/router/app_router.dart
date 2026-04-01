import 'package:go_router/go_router.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/todos/presentation/todo_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/todos',
  routes: [
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodoScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);