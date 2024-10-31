import 'package:flutter/material.dart';
import 'main.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ImageEntranceAnimation(),
      ),
    );
  }
}

class ImageEntranceAnimation extends StatefulWidget {
  const ImageEntranceAnimation({super.key});

  @override
  _ImageEntranceAnimationState createState() => _ImageEntranceAnimationState();
}

class _ImageEntranceAnimationState extends State<ImageEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Offset>> _positionAnimations;
  late Animation<Offset> _textAnimation;
  bool _showText = false;

  final List<String> imagePaths = [
    'images/v.png',
    'images/g-red.png',
    'images/g-yellow.png',
    'images/16.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimations = List.generate(imagePaths.length, (index) {
      return Tween<double>(begin: 10.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / imagePaths.length, 1.0, curve: Curves.easeInOut),
        ),
      );
    });

    _positionAnimations = List.generate(imagePaths.length, (index) {
      double startX = (index - imagePaths.length / 2) * 200.0;
      return Tween<Offset>(
        begin: Offset(startX, 0.0),
        end: Offset((index - imagePaths.length / 2) * 3.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / imagePaths.length, 1.0, curve: Curves.easeInOut),
        ),
      );
    });

    _textAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(1.0, 5.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward().then((_) {
      setState(() {
        _showText = true;
      });

      // 2초 후에 'main.dart'에 정의된 화면으로 이동
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Main()), 
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_showText) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imagePaths.length, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: _positionAnimations[index].value,
                        child: Transform.scale(
                          scale: _scaleAnimations[index].value,
                          child: Image.asset(
                            imagePaths[index],
                            width: 40,
                            height: 40,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
            if (_showText) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(imagePaths.length, (index) {
                      return Transform.translate(
                        offset: _positionAnimations[index].value,
                        child: Transform.scale(
                          scale: _scaleAnimations[index].value,
                          child: Image.asset(
                            imagePaths[index],
                            width: 40,
                            height: 40,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: _textAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: _textAnimation.value,
                        child: child,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'classification',
                        style: TextStyle(color: Color.fromARGB(255, 120, 120, 120), fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
