import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: HomeScreen(),
      routes: {
        '/main': (context) => MainScreen(), // 이동할 페이지 설정
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/main'); // 첫 번째 박스 클릭 시 이동
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 10), // 간격 조정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/profile_blue.png'), // 이미지 경로
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // 적당한 간격 추가
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 10), // 간격 조정
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile_red.png'), // 이미지 경로
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50, // 상단 여백을 조정하여 아래로 내림
            right: 20, // 우측 여백
            child: Text(
              '변경',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen')),
      body: Center(
        child: Text(
          '여기는 Main 페이지입니다.',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}