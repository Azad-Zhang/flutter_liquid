/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-27 16:27:02
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-27 16:38:49
 * @FilePath: /my_flutter_template_getx/lib/app/modules/home/widgets/aaa.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedWaveBlurExample222 extends StatefulWidget {
  const AnimatedWaveBlurExample222({super.key});

  @override
  _AnimatedWaveBlurExample222State createState() =>
      _AnimatedWaveBlurExample222State();
}

class _AnimatedWaveBlurExample222State extends State<AnimatedWaveBlurExample222>
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
          painter: BlurredWavePainter(_animation.value),
          size: const Size(300, 200),
        );
      },
    );
  }
}

class BlurredWavePainter extends CustomPainter {
  final double progress;

  BlurredWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final gradient = LinearGradient(
      colors: [Colors.red, Colors.yellow],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final paint = Paint()
      // ..imageFilter = ImageFilter.blur(sigmaX: -100, sigmaY: -100)
      ..imageFilter = ImageFilter.blur(sigmaX:18, sigmaY: 18,tileMode: TileMode.decal)
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final waveWidth = 100.0;
    final waveHeight = 20.0;

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
  bool shouldRepaint(covariant BlurredWavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
