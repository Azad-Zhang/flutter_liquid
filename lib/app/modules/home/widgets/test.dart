import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedWaveExample extends StatefulWidget {
  const AnimatedWaveExample({super.key});

  @override
  _AnimatedWaveExampleState createState() => _AnimatedWaveExampleState();
}

class _AnimatedWaveExampleState extends State<AnimatedWaveExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_animation.value),
          size: const Size(300, 200),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;

  WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [Color(0xFFFF9797).withOpacity(0.45), Color(0xFFFF2C2C).withOpacity(0.45)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

     // 阴影画笔
    final shadowPaint = Paint()
      ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5)
      ..color = Colors.black.withOpacity(0.3);

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveWidth = 100.0;
    final waveHeight = 20.0;

    final shadowOffset = Offset(5, 5); // 阴影偏移


    // 绘制阴影
    final shadowPath = path.shift(shadowOffset);
    canvas.saveLayer(null, shadowPaint);
    canvas.drawPath(shadowPath, Paint());
    canvas.restore();


    path.moveTo(0, size.height / 2);
    for (double x = 0; x <= size.width; x++) {
      final y = size.height / 2 +
          waveHeight * sin((x / waveWidth + progress * 2 * pi));
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}    