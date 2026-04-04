import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'widgets/todo_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import 'widgets/todo_editor_dialog.dart';

class TodoDetailsScreen extends ConsumerWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: TodoDetails(
        todo: todo,
        onEdit: () {
          _showEditDialog(context, ref);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
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