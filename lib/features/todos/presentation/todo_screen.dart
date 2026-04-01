import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/todo_provider.dart';
import 'widgets/todo_item.dart';
import '../models/todo_filter.dart';

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
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final text = controller.text.trim();

                if (text.isNotEmpty) {
                  await ref.read(todoProvider.notifier).addTodo(text);
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
    final todosAsync = ref.watch(filteredTodosProvider);
    final selectedFilter = ref.watch(todoFilterProvider);
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          final content = Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SegmentedButton<TodoFilter>(
                  segments: const [
                    ButtonSegment(
                      value: TodoFilter.all,
                      label: Text('All'),
                    ),
                    ButtonSegment(
                      value: TodoFilter.active,
                      label: Text('Active'),
                    ),
                    ButtonSegment(
                      value: TodoFilter.completed,
                      label: Text('Completed'),
                    ),
                  ],
                  selected: {selectedFilter},
                  onSelectionChanged: (selection) {
                    ref
                        .read(todoFilterProvider.notifier)
                        .setFilter(selection.first);
                  },
                ),
              ),
              Expanded(
                child: todosAsync.when(
                  data: (todos) {
                    if (todos.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No todos yet'),
                          ],
                        ),
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
              ),
            ],
          );

          if (isWide) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: content,
              ),
            );
          }

          return SafeArea(child: content);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTodoDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
    );
  }
}