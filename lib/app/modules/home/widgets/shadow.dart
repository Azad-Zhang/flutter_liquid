import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';

class MovingWaveShadowWidget extends StatefulWidget {
  final Gradient originalGradient;

  const MovingWaveShadowWidget({
    Key? key,
    required this.originalGradient,
  }) : super(key: key);

  @override
  _MovingWaveShadowWidgetState createState() => _MovingWaveShadowWidgetState();
}

class _MovingWaveShadowWidgetState extends State<MovingWaveShadowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _offsetAnimation = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Container(
          width: ScreenAdapter.height(200),
          height: ScreenAdapter.height(200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red,
              width: 1,
            ),
          ),
          child: CustomPaint(
            painter: _WaveShadowPainter(
              _offsetAnimation.value,
              widget.originalGradient,
            ),
          ),
        );
      },
    );
  }
}

class _WaveShadowPainter extends CustomPainter {
  final double offset;
  final Gradient originalGradient;

  _WaveShadowPainter(this.offset, this.originalGradient);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // 第一步：绘制红色阴影
    final shadowPath = _createWavePath(size, offset);
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));
    canvas.drawPath(shadowPath, Paint()..color = Color(0xFFD81C1C));
    canvas.restore();

    // 第二步：绘制模糊的渐变波浪
    final blurWavePaint = Paint()
      ..shader = originalGradient.createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ))
      ..imageFilter = ImageFilter.blur(
        sigmaX: 8,
        sigmaY: 8,
        tileMode: TileMode.decal, // 使用clamp模式防止边缘裁切
      );

    canvas.save();
    // 应用偏移并保留模糊溢出
    //偏移这里需要做一下适配
    canvas.translate(size.width * 0.06, size.height * 0.06);
    
    // 创建扩展的绘制区域（增加10%的绘制范围）
    final extendedRect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height
    );

    // // 在新的绘制区域绘制波浪
    canvas.saveLayer(extendedRect, blurWavePaint);
    canvas.drawPath(_createWavePath(size, offset), Paint()..shader = originalGradient.createShader(extendedRect));
    canvas.restore();

    // 第三步：应用圆形蒙版
    final clipPath = Path()
      ..addOval(Rect.fromCircle(
        center: center,
        radius: radius - max(size.width * 0.06, size.height * 0.06),
      ));
    canvas.clipPath(clipPath);
    canvas.restore();
  }

  Path _createWavePath(Size size, double phase) {
    final path = Path();
    final waveHeight = 18.0;
    final baseY = size.height * 0.48;

    path.moveTo(-50, baseY); // 左侧扩展绘制区域
    for (double x = -50; x <= size.width + 50; x++) {
      final y = baseY + waveHeight * sin((x / size.width * 4 * pi) + phase * 2 * pi);
      path.lineTo(x, y);
    }
    path.lineTo(size.width + 50, size.height + 50); // 右侧和下侧扩展
    path.lineTo(-50, size.height + 50);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _WaveShadowPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.originalGradient != originalGradient;
  }
}

// 使用示例
class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: MovingWaveShadowWidget(
          originalGradient: LinearGradient(
            colors: [
              Color(0xFFFF9797).withOpacity(0.6),
              Color(0xFFFF2C2C).withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}