import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedWaveInnerShadowWidget extends StatefulWidget {
  final double width;
  final double height;
  final List<Color> waveColors;
  final double blurRadius;
  final Offset offset;
  final Color shadowColor;
  final Color innerShadowColor;
  final double innerBlurRadius;
  final Duration animationDuration;

  const AnimatedWaveInnerShadowWidget({
    Key? key,
    required this.width,
    required this.height,
    this.waveColors = const [Colors.blue, Colors.lightBlue],
    this.blurRadius = 10.0,
    this.offset = const Offset(0, 0),
    this.shadowColor = Colors.black,
    this.innerShadowColor = Colors.black54,
    this.innerBlurRadius = 5.0,
    this.animationDuration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  _AnimatedWaveInnerShadowWidgetState createState() =>
      _AnimatedWaveInnerShadowWidgetState();
}

class _AnimatedWaveInnerShadowWidgetState
    extends State<AnimatedWaveInnerShadowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
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
          size: Size(widget.width, widget.height),
          painter: WaveInnerShadowPainter(
            waveColors: widget.waveColors,
            blurRadius: widget.blurRadius,
            offset: widget.offset,
            shadowColor: widget.shadowColor,
            innerShadowColor: widget.innerShadowColor,
            innerBlurRadius: widget.innerBlurRadius,
            animationValue: _animation.value,
          ),
        );
      },
    );
  }
}

class WaveInnerShadowPainter extends CustomPainter {
  final List<Color> waveColors;
  final double blurRadius;
  final Offset offset;
  final Color shadowColor;
  final Color innerShadowColor;
  final double innerBlurRadius;
  final double animationValue;

  WaveInnerShadowPainter({
    required this.waveColors,
    required this.blurRadius,
    required this.offset,
    required this.shadowColor,
    required this.innerShadowColor,
    required this.innerBlurRadius,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waveHeight = 20.0;
    final waveLength = size.width;
    final phase = animationValue * waveLength;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    for (double x = 0; x < size.width; x++) {
      final y = size.height * 0.5 +
          waveHeight * sin((x + phase) * (2 * 3.1415926 / waveLength));
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // 绘制外阴影
    final outerShadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);
    canvas.drawPath(path.shift(offset), outerShadowPaint);

    // 绘制内阴影
    final innerShadowPaint = Paint()
      ..color = innerShadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, innerBlurRadius);
    canvas.drawPath(path, innerShadowPaint);

    final gradient = LinearGradient(
      colors: waveColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    final wavePaint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant WaveInnerShadowPainter oldDelegate) {
    return oldDelegate.waveColors != waveColors ||
        oldDelegate.blurRadius != blurRadius ||
        oldDelegate.offset != offset ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.innerShadowColor != innerShadowColor ||
        oldDelegate.innerBlurRadius != innerBlurRadius ||
        oldDelegate.animationValue != animationValue;
  }
}    