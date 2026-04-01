import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/todo_provider.dart';
import 'widgets/todo_item.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final trimmedText = controller.text.trim();
                if (trimmedText.isNotEmpty) {
                  await ref.read(todoProvider.notifier).addTodo(trimmedText);
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoProvider);
    final notifier = ref.read(todoProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: todosAsync.when(
        data: (todos) {
          if (todos.isEmpty) {
            return const Center(
              child: Text('No todos yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoItem(
                todo: todo,
                onToggle: () => notifier.toggleTodo(todo.id),
                onDelete: () => notifier.deleteTodo(todo.id),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}