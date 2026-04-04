import 'package:go_router/go_router.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/todos/presentation/todo_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.todos,
  routes: [
    GoRoute(
      path: AppRoutes.todos,
      builder: (context, state) => const TodoScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);