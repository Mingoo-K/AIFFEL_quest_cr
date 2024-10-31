import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatelessWidget {
  final Function(String) onImageSelected;

  const ImagePickerPage({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('이미지 선택')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  onImageSelected(pickedFile.path);
                  Navigator.pop(context);
                }
              },
              child: const Text('카메라에서 이미지 찍기'),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  onImageSelected(pickedFile.path);
                  Navigator.pop(context);
                }
              },
              child: const Text('갤러리에서 이미지 선택하기'),
            ),
          ],
        ),
      ),
    );
  }
}
