import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;

  const TodoDetails({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Center(
          child: Text(
            'Todo: ${todo.title}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}