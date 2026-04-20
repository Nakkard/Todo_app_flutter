import 'package:flutter/material.dart';
import 'package:todo_app/core/ui/adaptive_extension.dart';
import '../../../../core/l10n/l10n.dart';
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
      padding: EdgeInsets.all(16.a),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.a),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.a),
                if (todo.imagePath != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.a),
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
                  SizedBox(height: 24.a),
                ],
                FilledButton(onPressed: onEdit, child: Text(L10n.edit)),
                SizedBox(height: 12.a),
                TodoImagePickerButton(onImagePicked: onImagePicked),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
