import 'package:flutter/material.dart';
import 'quest_13_second.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Navigation',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isCat = false;

  void _navigateToSecondPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(isCat: isCat),
      ),
    );
    // 페이지에서 반환된 결과를 처리할 수 있습니다.
    setState(() {
      isCat = result ?? isCat; // 결과에 따라 isCat을 업데이트
    });
  }

  void _printCatState() {
    print("Current is_cat state: $isCat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        leading: Icon(FontAwesomeIcons.cat), // 고양이 아이콘
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _navigateToSecondPage,
              child: Text("Next"),
            ),
            GestureDetector(
              onTap: _printCatState,
              child: Image.asset(
                'images/cat.jpg', // 고양이 이미지 경로
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

/* 페이지별로 파일을 만들어 작성하였다.
  고양이와 강아지 아이콘을 추가하는데 약간의 시간이 필요했다.
  전체적인 틀을 조언을 받아 작성한 후 필요한 부분의 의 세부적인 코드를 수정하여 가며 작성하였다*/
