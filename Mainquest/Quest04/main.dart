import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'seclect.dart'; // 결과 페이지 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 95),
                  child: Image.asset(
                    'images/search.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 사진 찍기 이미지 및 텍스트
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openCamera(context);
                      },
                      child: Image.asset(
                        'images/lens.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '사진 찍기',
                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 150, 150, 150)),
                    ),
                  ],
                ),
                const SizedBox(width: 60),
                // 갤러리 이미지 및 텍스트
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openGallery(context);
                      },
                      child: Image.asset(
                        'images/gallery.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '갤 러 리',
                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 150, 150, 150)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 카메라 열기
  void _openCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // 결과 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectPage(cameraImagePath: image.path),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사진 찍기 취소됨.')),
      );
    }
  }

  // 갤러리 열기
  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // 결과 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectPage(galleryImagePath: image.path),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('갤러리 선택 취소됨.')),
      );
    }
  }
}
