import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> _todos = [];

  void _addTodo(String title) {
    setState(() {
      _todos.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
        ),
      );
    });
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  void _showAddTodoDialog() {
    String input = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
            ),
            onChanged: (value) {
              input = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final trimmed = input.trim();

                if (trimmed.isNotEmpty) {
                  _addTodo(trimmed);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _todos.isEmpty
          ? const Center(
        child: Text('No todos yet'),
      )
          : ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];

          return ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) {
                _toggleTodo(todo.id);
              },
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration:
                todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                _deleteTodo(todo.id);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}