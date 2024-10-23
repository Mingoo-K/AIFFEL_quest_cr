import 'package:flutter/material.dart';
import 'quest04_profile.dart';
import 'quest04_main.dart';
import 'quest04_intended.dart';
import 'quest04_contents.dart';
import 'quest04_top10.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너를 숨김
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Onbaord(),
        '/profile': (context) => const Profile(),
        '/main': (context) => const Main(),
      },
    );
  }
}

class Onbaord extends StatelessWidget {
  const Onbaord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/Profile');
          },
          child: Image.asset('images/netflix.png'),
        ),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          '여기는 메인 페이지입니다.',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}