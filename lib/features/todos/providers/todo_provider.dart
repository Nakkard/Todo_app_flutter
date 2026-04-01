import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../data/todo_repository.dart';
import '../models/todo_filter.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
      (ref) => TodoRepository(),
);

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoRepository _repository;

  @override
  Future<List<Todo>> build() async {
    _repository = ref.read(todoRepositoryProvider);
    return _repository.loadTodos();
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    await _repository.saveTodos(todos);
  }

  Future<void> addTodo(String title) async {
    final currentTodos = state.value ?? [];

    final updatedTodos = [
      ...currentTodos,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ),
    ];

    state = AsyncData(updatedTodos);
    await _saveTodos(updatedTodos);
  }

  Future<void> toggleTodo(String id) async {
    final currentTodos = state.value ?? [];

    final updatedTodos = currentTodos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();

    state = AsyncData(updatedTodos);
    await _saveTodos(updatedTodos);
  }

  Future<void> deleteTodo(String id) async {
    final currentTodos = state.value ?? [];

    final updatedTodos = currentTodos.where((t) => t.id != id).toList();

    state = AsyncData(updatedTodos);
    await _saveTodos(updatedTodos);
  }
}

final todoProvider =
AsyncNotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,


);

