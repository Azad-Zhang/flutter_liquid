import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';

// 常量定义
const _kDefaultBorder = Border.fromBorderSide(BorderSide(color: Colors.red, width: 1));
const _kDefaultDuration = Duration(seconds: 2);
const _kDefaultSize = 100.0;
const _kDefaultPadding = 10.0;

class LiquidBallWidget extends StatefulWidget {
  final Gradient? waveGradient;    // 波浪渐变色
  final Color? waveColor;          // 波浪单色
  final Duration animationDuration;// 动画时长
  final double containerSize;      // 容器尺寸
  final double containerPadding;   // 内边距
  final Border containerBorder;    // 容器边框

  const LiquidBallWidget({
    Key? key,
    this.waveGradient,
    this.waveColor,
    this.animationDuration = _kDefaultDuration,
    this.containerSize = _kDefaultSize,
    this.containerPadding = _kDefaultPadding,
    this.containerBorder = _kDefaultBorder,
  }) : assert(
          (waveGradient != null && waveColor == null) || 
          (waveGradient == null && waveColor != null),
          'waveGradient 和 waveColor 只能传一个参数',
        ),
        super(key: key);

  @override
  _LiquidBallState createState() => _LiquidBallState();
}

class _LiquidBallState extends State<LiquidBallWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat();
    
    _waveAnimation = _waveController.drive(
      Tween<double>(begin: 0.0, end: 1.0),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return Container(
          width: widget.containerSize,
          height: widget.containerSize,
          padding: EdgeInsets.all(widget.containerPadding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: widget.containerBorder,
          ),
          child: CustomPaint(
            painter: _LiquidWavePainter(
              animationValue: _waveAnimation.value,
              waveGradient: widget.waveGradient,
              waveColor: widget.waveColor,
            ),
          ),
        );
      },
    );
  }
}

class _LiquidWavePainter extends CustomPainter {
  final double animationValue;
  final Gradient? waveGradient;
  final Color? waveColor;

  _LiquidWavePainter({
    required this.animationValue,
    this.waveGradient,
    this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final phase = animationValue % 1.0;
    final path = _createWavePath(size, phase);

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final wavePath = _createWavePath(size, animationValue);
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    if (waveGradient != null) {
      final paint = Paint()
        ..shader = waveGradient!.createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawPath(wavePath, paint);
    } else if (waveColor != null) {
      canvas.drawPath(wavePath, Paint()..color = waveColor!);
    }

    canvas.restore();
  }

  Path _createWavePath(Size size, double phase) {
    const waveAmplitude = 16.0;
    final baseHeight = size.height * 0.52;
    const horizontalPadding = 50.0;

    final path = Path();
    path.moveTo(-horizontalPadding, baseHeight);

    const waveFrequency = 3.5;
    for (double x = -horizontalPadding; x <= size.width + horizontalPadding; x++) {
      final radians = (x / size.width * waveFrequency * pi) + (phase * 2 * pi);
      final y = baseHeight + waveAmplitude * sin(radians);
      path.lineTo(x, y);
    }

    path.lineTo(size.width + horizontalPadding, size.height + 100);
    path.lineTo(-horizontalPadding, size.height + 100);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _LiquidWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.waveGradient != waveGradient ||
           oldDelegate.waveColor != waveColor;
  }
}