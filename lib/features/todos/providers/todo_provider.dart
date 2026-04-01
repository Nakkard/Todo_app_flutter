import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../data/todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
      (ref) => TodoRepository(),
);

class TodoNotifier extends Notifier<List<Todo>> {
  late final TodoRepository _repository;

  @override
  List<Todo> build() {
    _repository = ref.read(todoRepositoryProvider);
    _loadTodos();
    return [];
  }

  Future<void> _loadTodos() async {
    final todos = await _repository.loadTodos();
    state = todos;
  }

  Future<void> _saveTodos() async {
    await _repository.saveTodos(state);
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