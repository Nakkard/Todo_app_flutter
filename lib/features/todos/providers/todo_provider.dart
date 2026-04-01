import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(String title) {
    state = [
      ...state,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ),
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();
  }

  void deleteTodo(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);