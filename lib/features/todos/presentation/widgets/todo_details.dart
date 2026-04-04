import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  final VoidCallback onEdit;

  const TodoDetails({
    super.key,
    required this.todo,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}