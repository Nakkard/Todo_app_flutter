import 'package:flutter/material.dart';
import '../../models/todo.dart';
import 'dart:io';
import 'todo_image_picker_button.dart';
import 'package:flutter/foundation.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  final VoidCallback onEdit;
  final ValueChanged<String> onImagePicked;

  const TodoDetails({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (todo.imagePath != null) ...[
                  Builder(
                    builder: (context) {
                      return const SizedBox.shrink();
                    },
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(
                      todo.imagePath!,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(todo.imagePath!),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                FilledButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
                const SizedBox(height: 12),
                TodoImagePickerButton(
                  onImagePicked: onImagePicked,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}