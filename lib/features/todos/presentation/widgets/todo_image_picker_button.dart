import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TodoImagePickerButton extends StatelessWidget {
  final ValueChanged<String> onImagePicked;

  const TodoImagePickerButton({
    super.key,
    required this.onImagePicked,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      onImagePicked(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.image),
      label: const Text('Attach image'),
    );
  }
}