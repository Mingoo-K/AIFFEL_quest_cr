import 'package:flutter/material.dart';
import 'dart:io';
import 'main.dart';
import 'result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          onPressed: () async {
            // 예측 결과를 가져오는 동안 로딩 표시
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            try {
              String predictionResult = await _fetchPrediction(imagePath);

              // 로딩 종료
              Navigator.pop(context);

              // 예측 결과 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    predictionResult: predictionResult,
                    imagePath: imagePath,
                  ),
                ),
              );
            } catch (e) {
              // 로딩 종료
              Navigator.pop(context);

              // 오류 메시지 표시
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('오류 발생: $e')),
              );
            }
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

  Future<String> _fetchPrediction(String imagePath) async {
    var uri = Uri.parse('https://ae91-34-105-106-118.ngrok-free.app/upload');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    print('Sending request to server...');

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response Data: $responseData'); // 응답 데이터 출력
        var decodedData = json.decode(responseData);

        if (!decodedData.containsKey('predicted_label')) {
          throw Exception('예측 결과가 없습니다.');
        }

        return decodedData['predicted_label'];
      } else {
        throw Exception('Failed to get prediction from server');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('서버와의 통신 중 오류가 발생했습니다.');
    }
  }

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
