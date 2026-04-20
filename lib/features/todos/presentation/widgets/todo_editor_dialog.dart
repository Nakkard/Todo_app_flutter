import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TodoEditorDialog extends StatefulWidget {
  final String title;
  final String actionText;
  final String? initialText;
  final ValueChanged<String> onSubmit;

  const TodoEditorDialog({
    super.key,
    required this.title,
    required this.actionText,
    this.initialText,
    required this.onSubmit,
  });

  @override
  State<TodoEditorDialog> createState() => _TodoEditorDialogState();
}

class _TodoEditorDialogState extends State<TodoEditorDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    widget.onSubmit(text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: 2,
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'.tr()),
        ),
        ElevatedButton(onPressed: _submit, child: Text(widget.actionText)),
      ],
    );
  }
}
