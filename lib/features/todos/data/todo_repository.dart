import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoRepository {
  static const _storageKey = 'todos';

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(
      todos.map((e) => e.toJson()).toList(),
    );

    await prefs.setString(_storageKey, jsonString);
  }
}