import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'widgets/todo_details.dart';

class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: TodoDetails(todo: todo),
    );
  }
}