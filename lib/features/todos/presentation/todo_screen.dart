import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/ui/adaptive_extension.dart';
import 'package:todo_app/features/todos/presentation/widgets/todo_mobile_layout.dart';
import 'package:todo_app/features/todos/presentation/widgets/todo_tablet_layout.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/ui/adaptive.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import 'widgets/todo_item.dart';
import '../models/todo_filter.dart';
import '../../../core/router/app_routes.dart';
import 'todo_details_screen.dart';
import 'widgets/todo_editor_dialog.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.todoApp),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenType = getScreenType(constraints.maxWidth);
          final isWide = screenType != ScreenType.mobile;

          final todosAsync = ref.watch(filteredTodosProvider);
          final selectedTodoId = ref.watch(selectedTodoIdProvider);
          final notifier = ref.read(todoProvider.notifier);

          Todo? selectedTodo;

          todosAsync.when(
            data: (todos) {
              final matches = todos
                  .where((t) => t.id == selectedTodoId)
                  .toList();

              selectedTodo = matches.isNotEmpty ? matches.first : null;
            },
            loading: () {},
            error: (_, __) {},
          );

          final selectedFilter = ref.watch(todoFilterProvider);

          Widget list = Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.a),
                child: SegmentedButton<TodoFilter>(
                  segments: [
                    ButtonSegment(
                      value: TodoFilter.all,
                      label: Text(L10n.all),
                    ),
                    ButtonSegment(
                      value: TodoFilter.active,
                      label: Text(L10n.active),
                    ),
                    ButtonSegment(
                      value: TodoFilter.completed,
                      label: Text(L10n.completed),
                    ),
                  ],
                  selected: {selectedFilter},
                  onSelectionChanged: (selection) {
                    ref
                        .read(todoFilterProvider.notifier)
                        .setFilter(selection.first);
                  },
                ),
              ),
              Expanded(
                child: todosAsync.when(
                  data: (todos) {
                    if (todos.isEmpty) {
                      return Center(child: Text(L10n.noTodos));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(8.a),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        return TodoItem(
                          todo: todo,
                          onToggle: () => notifier.toggleTodo(todo.id),
                          onDelete: () async {
                            await notifier.deleteTodo(todo.id);

                            if (selectedTodoId == todo.id) {
                              ref.read(selectedTodoIdProvider.notifier).clear();
                            }

                            _showUndoDeleteSnackBar(context, ref, todo);
                          },
                          onTap: () {
                            if (isWide) {
                              ref
                                  .read(selectedTodoIdProvider.notifier)
                                  .select(todo.id);
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    TodoDetailsScreen(todoId: todo.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
            ],
          );

          return switch (screenType) {
            ScreenType.mobile => TodoMobileLayout(list: list),
            ScreenType.tablet => TodoTabletLayout(
              list: list,
              selectedTodo: selectedTodo,
              onEdit: selectedTodo == null
                  ? null
                  : () {
                      _showTodoDialog(
                        context,
                        ref,
                        initialText: selectedTodo!.title,
                        todoId: selectedTodo!.id,
                      );
                    },
              onImagePicked: selectedTodo == null
                  ? null
                  : (path) async {
                      await ref
                          .read(todoProvider.notifier)
                          .updateTodoImage(selectedTodo!.id, path);
                    },
            ),
            ScreenType.desktop => TodoTabletLayout(
              list: list,
              selectedTodo: selectedTodo,
              onEdit: selectedTodo == null
                  ? null
                  : () {
                      _showTodoDialog(
                        context,
                        ref,
                        initialText: selectedTodo!.title,
                        todoId: selectedTodo!.id,
                      );
                    },
              onImagePicked: selectedTodo == null
                  ? null
                  : (path) async {
                      await ref
                          .read(todoProvider.notifier)
                          .updateTodoImage(selectedTodo!.id, path);
                    },
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTodoDialog(context, ref),
        icon: const Icon(Icons.add),
        label: Text(L10n.addTodo),
      ),
    );
  }

  void _showTodoDialog(
    BuildContext context,
    WidgetRef ref, {
    String? initialText,
    String? todoId,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return TodoEditorDialog(
          title: todoId == null ? L10n.addTodo : L10n.editTodo,
          actionText: todoId == null ? L10n.addTodo : L10n.save,
          initialText: initialText,
          onSubmit: (text) async {
            if (todoId == null) {
              await ref.read(todoProvider.notifier).addTodo(text);
            } else {
              await ref.read(todoProvider.notifier).updateTodo(todoId, text);
            }
          },
        );
      },
    );
  }

  void _showUndoDeleteSnackBar(
    BuildContext context,
    WidgetRef ref,
    Todo deletedTodo,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('todo_deleted', args: [deletedTodo.title])),
        action: SnackBarAction(
          label: tr('undo'),
          onPressed: () {
            ref.read(todoProvider.notifier).restoreTodo(deletedTodo);
          },
        ),
      ),
    );
  }
}
