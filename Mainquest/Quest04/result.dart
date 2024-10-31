import 'package:flutter/material.dart';
import 'dart:io';
import 'main.dart'; // main.dart 파일 import
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 import

class ResultPage extends StatelessWidget {
  final String predictionResult;
  final String? imagePath; // 이미지 경로 추가

  const ResultPage({super.key, required this.predictionResult, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('images/result.png', width: 150, height: 150),
          const SizedBox(height: 50),
          Center(
            child: Text(
              '예측 결과 : $predictionResult',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 40), // 예측 결과와 이미지 사이 간격
          if (imagePath != null) // 이미지 경로가 있을 경우에만 이미지 표시
            Image.file(File(imagePath!), width: 250, height: 318),
          const SizedBox(height: 30), // 이미지와 버튼 사이 간격
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.google.com/search?q=$predictionResult');
                  try {
                    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                  } catch (e) {
                    // URL 실행 실패 시 스낵바 표시
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('URL을 열 수 없습니다: $e')),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                  //padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 패딩 줄임
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/google.png', width: 24, height: 24), // 검색 아이콘
                    const SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                    const Text(
                      '구글 검색',
                      style: TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // 하단 메뉴바 추가
    );
  }

  // 하단 네비게이션 바를 만드는 위젯 (SelectPage에서 가져옴)
  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('images/back.png', width: 25, height: 25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Main()),
              );
            },
            child: Image.asset('images/home.png', width: 25, height: 25),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}
