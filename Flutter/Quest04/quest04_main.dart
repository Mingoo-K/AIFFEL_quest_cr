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
      backgroundColor: const Color.fromARGB(255, 30, 36, 110),
      body: Stack(
        children: [
          // '강민구님' 텍스트
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              '강민구님',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          // 큰 박스 두 개
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 작은 박스를 중간 박스의 시작 지점에서 나오게
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    SizedBox(width: 0), // 중간 박스의 시작 지점까지 간격 추가
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/main'); // 첫 번째 박스 클릭 시 이동
                      },
                      child: Container(
                        width: 92,
                        height: 25,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.transparent, // 배경을 투명하게 설정
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/series.png', // 박스 1의 이미지 경로
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 92,
                      height: 25,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 배경을 투명하게 설정
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/movie.png', // 박스 2의 이미지 경로
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // 두 줄 사이의 간격
                // 중간 큰 박스
                Container(
                  width: 330,
                  height: 330,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'images/center.png', // 중간 박스의 이미지 경로
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20), // 큰 박스와 아래 박스들 사이의 간격
                // 중간 박스 세 개
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/smovie.png', // 박스 3의 이미지 경로
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/smovie.png', // 박스 4의 이미지 경로
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/smovie.png', // 박스 5의 이미지 경로
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // 큰 박스와 아래 박스들 사이의 간격
              ],
            ),
          ),
          // 가장 아래쪽에 작은 회색 박스 3개
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 맞게 정렬
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text('홈', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text('New & Hot', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text('나의 넷플릭스', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10), // 텍스트와 박스 사이의 간격
              ],
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