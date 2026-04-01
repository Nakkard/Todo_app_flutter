import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoNotifier extends Notifier<List<Todo>> {
  static const _storageKey = 'todos';

  @override
  List<Todo> build() {
    _loadTodos();
    return [];
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);

      state = decoded
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(
      state.map((e) => e.toJson()).toList(),
    );

    await prefs.setString(_storageKey, jsonString);
  }

  void addTodo(String title) {
    state = [
      ...state,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ),
    ];
    _saveTodos();
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();
    _saveTodos();
  }

  void deleteTodo(String id) {
    state = state.where((t) => t.id != id).toList();
    _saveTodos();
  }
}

final todoProvider =
NotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);