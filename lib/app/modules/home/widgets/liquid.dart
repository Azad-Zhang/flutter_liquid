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
  final double waveSpeed; // 控制波浪的左右滚动速度
  final double waveHeightFactor; // 控制波浪的高度
  final double waveRiseSpeed; // 控制波浪的升起速度

  const LiquidBall({
    super.key,
    required this.size,
    this.waveSingleColor,
    this.waveGradientColor,
    this.borderColor = Colors.blue,
    this.padding,
    this.borderWidth = 2.0,
    required this.percentage,
    this.waveSpeed = 1.0, // 默认值
    this.waveHeightFactor = 0.1, // 默认值
    this.waveRiseSpeed = 1.0, // 默认值
  })  : assert(
            (waveSingleColor == null && waveGradientColor != null) ||
                (waveSingleColor != null && waveGradientColor == null),
            'You can only pass either a single color or a gradient for the wave, not both.'),
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
    // 高度动画控制器，只执行一次
    _heightController = AnimationController(
      vsync: this,
      duration: Duration(
          seconds:
              (2 / widget.waveRiseSpeed).round()), // 根据 waveRiseSpeed 调整动画时长
    );
    _heightAnimation =
        Tween<double>(begin: 0, end: widget.percentage / 100).animate(
      CurvedAnimation(
        parent: _heightController,
        curve: Curves.easeOut,
      ),
    );
    _heightController.forward();

    // 波浪滚动动画控制器，持续重复
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: (3 / widget.waveSpeed).round()), // 根据 waveSpeed 调整动画时长
    )..repeat();
    _waveAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_waveController);
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

  WavePainter({
    required this.waveAnimation,
    this.waveSingleColor,
    this.waveGradientColor,
    required this.percentage,
    required this.waveHeightFactor,
  }) : super(repaint: waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    if (waveSingleColor != null) {
      paint.color = waveSingleColor!;
    } else if (waveGradientColor != null) {
      // 修改为 RadialGradient
      paint.shader = RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: waveGradientColor!.colors,
        stops: waveGradientColor!.stops,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    // if (waveSingleColor != null) {
    //   paint.color = waveSingleColor!;
    // } else if (waveGradientColor != null) {
    //   paint.shader = waveGradientColor!
    //       .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    // }

    paint.style = PaintingStyle.fill;

    final baseWaveHeight = size.height * waveHeightFactor;
    final path = Path();
    final baseHeight = size.height - size.height * percentage;

    path.moveTo(0, baseHeight);
    for (double i = 0; i <= size.width; i++) {
      double totalWaveY = 0;

      double wave1 = sin((i / size.width * 2 * pi * 4) + waveAnimation.value);

      // 动态振幅（基于位置和时间的平滑变化）
      double dynamicAmplitude =
          0.5 + 0.2 * sin(i * 0.05 + waveAnimation.value * 2);

      totalWaveY -= baseWaveHeight * dynamicAmplitude * ((wave1 + 1) / 2);

      path.lineTo(i, baseHeight + totalWaveY);
    }
    path.lineTo(size.width, baseHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
