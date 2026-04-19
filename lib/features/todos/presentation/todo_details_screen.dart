import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'widgets/todo_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import 'widgets/todo_editor_dialog.dart';

class TodoDetailsScreen extends ConsumerWidget {
  final String todoId;

  const TodoDetailsScreen({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoProvider);
    Todo? todo;

    todosAsync.when(
      data: (todos) {
        final matches = todos.where((t) => t.id == todoId).toList();
        todo = matches.isNotEmpty ? matches.first : null;
      },
      loading: () {},
      error: (_, __) {},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: todosAsync.when(
        data: (_) {
          if (todo == null) {
            return const Center(child: Text('Todo not found'));
          }

          return TodoDetails(
            todo: todo!,
            onEdit: () {
              _showEditDialog(context, ref, todo!);
            },
            onImagePicked: (path) async {
              await ref
                  .read(todoProvider.notifier)
                  .updateTodoImage(todo!.id, path);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return TodoEditorDialog(
          title: 'Edit Todo',
          actionText: 'Save',
          initialText: todo.title,
          onSubmit: (text) async {
            await ref.read(todoProvider.notifier).updateTodo(todo.id, text);
          },
        );
      },
    );
  }
}
