import 'package:flutter/material.dart';
import 'dart:io';
import 'main.dart';
import 'result.dart';

class SelectPage extends StatelessWidget {
  final String? cameraImagePath;
  final String? galleryImagePath;

  const SelectPage({super.key, this.cameraImagePath, this.galleryImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('images/select.png', width: 150, height: 150),
          const SizedBox(height: 5),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cameraImagePath != null)
                    _buildImageSection('찍은 사진', cameraImagePath!, context),
                  if (galleryImagePath != null)
                    _buildImageSection('선택한 사진', galleryImagePath!, context),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 이미지와 예측 검색 버튼을 표시하는 위젯
  Widget _buildImageSection(String title, String imagePath, BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(imagePath),
              width: 330,
              height: 420,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextButton.icon(
          onPressed: () {
            // TODO: VGG16 예측 결과를 여기에서 가져와야 합니다.
            String predictionResult = "예측된 클래스 이름"; // 예시
            // ResultPage로 이동하며 예측 결과와 이미지 경로 전달
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  predictionResult: predictionResult,
                  imagePath: imagePath, // 이미지 경로 전달
                ),
              ),
            );
          },
          icon: Image.asset('images/wing.png', width: 24, height: 24),
          label: const Text(
            '예측 검색',
            style: TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
          ),
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 220, 220, 220),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  // 하단 네비게이션 바를 만드는 위젯
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
