import 'package:flutter/material.dart';
import 'dart:math';

class LiquidBall extends StatefulWidget {
  final double size;
  final Color? waveSingleColor;
  final Gradient? waveGradientColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;
  final int percentage;
  final double waveSpeed;
  final double waveHeightFactor;
  final double waveRiseSpeed;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset; // 新增阴影偏移属性

  const LiquidBall({
    super.key,
    required this.size,
    this.waveSingleColor,
    this.waveGradientColor,
    this.borderColor = Colors.blue,
    this.padding,
    this.borderWidth = 2.0,
    required this.percentage,
    this.waveSpeed = 1.0,
    this.waveHeightFactor = 0.1,
    this.waveRiseSpeed = 1.0,
    this.shadowColor = Colors.black54,
    this.shadowBlurRadius = 10.0,
    this.shadowOffset = const Offset(0, 0), // 设置默认偏移
  })  : assert((waveSingleColor == null && waveGradientColor != null) ||
            (waveSingleColor != null && waveGradientColor == null)),
        assert(percentage >= 0 && percentage <= 100),
        assert(waveSpeed > 0),
        assert(waveHeightFactor >= 0 && waveHeightFactor <= 1),
        assert(waveRiseSpeed > 0);

  @override
  State<LiquidBall> createState() => _LiquidBallState();
}

class _LiquidBallState extends State<LiquidBall> with TickerProviderStateMixin {
  late AnimationController _heightController;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _heightController = AnimationController(
      vsync: this,
      duration: Duration(seconds: (2 / widget.waveRiseSpeed).round()),
    );
    _heightAnimation = Tween<double>(begin: 0, end: widget.percentage / 100).animate(
      CurvedAnimation(
        parent: _heightController,
        curve: Curves.easeOut,
      ),
    );
    _heightController.forward();

    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: (3 / widget.waveSpeed).round()),
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(_waveController);
  }

  @override
  void dispose() {
    _heightController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_heightController, _waveController]),
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          padding: widget.padding,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.borderColor!,
              width: widget.borderWidth,
            ),
            color: Colors.transparent,
          ),
          child: ClipOval(
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: WavePainter(
                waveAnimation: _waveAnimation,
                waveSingleColor: widget.waveSingleColor,
                waveGradientColor: widget.waveGradientColor,
                percentage: _heightAnimation.value,
                waveHeightFactor: widget.waveHeightFactor,
                shadowColor: widget.shadowColor,
                shadowBlurRadius: widget.shadowBlurRadius,
                shadowOffset: widget.shadowOffset, // 传递偏移
              ),
            ),
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Color? waveSingleColor;
  final Gradient? waveGradientColor;
  final double percentage;
  final double waveHeightFactor;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset; // 接收偏移

  WavePainter({
    required this.waveAnimation,
    this.waveSingleColor,
    this.waveGradientColor,
    required this.percentage,
    required this.waveHeightFactor,
    required this.shadowColor,
    required this.shadowBlurRadius,
    required this.shadowOffset,
  }) : super(repaint: waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final baseHeight = size.height - size.height * percentage;
    final waveRange = size.height - baseHeight;

    // 绘制主波浪
    final paint = Paint();
    if (waveSingleColor != null) {
      paint.color = waveSingleColor!;
    } else if (waveGradientColor != null) {
      paint.shader = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: waveGradientColor!.colors,
        stops: waveGradientColor!.stops,
      ).createShader(Rect.fromLTWH(0, baseHeight, size.width, waveRange));
    }
    final wavePath = _drawWave(canvas, size, null, baseHeight, waveRange, Offset.zero, paint.shader);

    // 绘制带偏移的动态阴影
    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

    // 应用阴影偏移
    final shadowPath = Path()..addPath(wavePath, shadowOffset);
    canvas.drawPath(shadowPath, shadowPaint);
  }

  Path _drawWave(Canvas canvas, Size size, Color? color, double baseHeight, double waveRange, Offset offset, [Shader? shader]) {
    final paint = Paint();
    if (color != null) {
      paint.color = color;
    } else if (shader != null) {
      paint.shader = shader;
    }
    paint.style = PaintingStyle.fill;

    final baseWaveHeight = size.height * waveHeightFactor;
    final path = Path();
    path.moveTo(0 + offset.dx, baseHeight + offset.dy);
    for (double i = 0; i <= size.width; i++) {
      double totalWaveY = 0;

      double wave1 = sin((i / size.width * 2 * pi * 4) + waveAnimation.value);
      double dynamicAmplitude = 0.5 + 0.2 * sin(i * 0.05 + waveAnimation.value * 2);
      totalWaveY -= baseWaveHeight * dynamicAmplitude * ((wave1 + 1) / 2);

      path.lineTo(i + offset.dx, baseHeight + totalWaveY + offset.dy);
    }
    path.lineTo(size.width + offset.dx, baseHeight + offset.dy);
    path.lineTo(size.width + offset.dx, size.height + offset.dy);
    path.lineTo(0 + offset.dx, size.height + offset.dy);
    path.close();

    canvas.drawPath(path, paint);
    return path;
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
