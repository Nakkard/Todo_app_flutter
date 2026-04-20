import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/l10n/l10n.dart';

class TodoImagePickerButton extends StatelessWidget {
  final ValueChanged<String> onImagePicked;

  const TodoImagePickerButton({super.key, required this.onImagePicked});

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);

    if (file != null) {
      onImagePicked(file.path);
    }
  }

  void _showSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(L10n.pickFromGallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(L10n.takePhoto),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showSourcePicker(context),
      icon: const Icon(Icons.image),
      label: Text(L10n.attachImage),
    );
  }
}
