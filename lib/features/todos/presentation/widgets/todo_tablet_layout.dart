import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/presentation/widgets/todo_details.dart';
import '../../../../core/l10n/l10n.dart';
import '../../models/todo.dart';

class TodoTabletLayout extends StatelessWidget {
  final Widget list;
  final Todo? selectedTodo;
  final VoidCallback? onEdit;
  final ValueChanged<String>? onImagePicked;

  const TodoTabletLayout({
    super.key,
    required this.list,
    required this.selectedTodo,
    this.onEdit,
    this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: list),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: selectedTodo == null
              ? Center(child: Text(L10n.selectTodo))
              : TodoDetails(
                  todo: selectedTodo!,
                  onEdit: onEdit ?? () {},
                  onImagePicked: onImagePicked ?? (_) {},
                ),
        ),
      ],
    );
  }
}
