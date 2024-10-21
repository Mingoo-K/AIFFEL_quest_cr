import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SecondPage extends StatelessWidget {
  final bool isCat;

  SecondPage({required this.isCat});

  void _printDogState() {
    print("Current is_cat state: false");
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context, false); // true로 설정하여 is_cat을 false로 변환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        leading: Icon(FontAwesomeIcons.dog), // 강아지 아이콘
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goBack(context),
              child: Text("Back"),
            ),
            GestureDetector(
              onTap: _printDogState,
              child: Image.asset(
                'images/dog.jpg', // 강아지 이미지 경로
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
