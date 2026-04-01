import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
            todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}