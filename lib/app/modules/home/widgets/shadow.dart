import 'dart:math';
import 'package:flutter/material.dart';
// 假设 ScreenAdapter 是自定义的屏幕适配工具类
// 如果没有这个类，需要替换为相应的尺寸设置逻辑
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';

class MovingWaveShadowWidget extends StatefulWidget {
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
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red,
              width: 1,
            ),
            color: Colors.transparent,
          ),
          child: CustomPaint(
            size: Size(200, 200),
            painter: _WaveShadowPainter(_offsetAnimation.value),
          ),
        );
      },
    );
  }
}

class _WaveShadowPainter extends CustomPainter {
  final double offset;

  _WaveShadowPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    // 创建圆形裁剪路径
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));
    canvas.clipPath(circlePath);

    // 绘制阴影部分
    final shadowPath = _createWavePath(size, offset);
    final shadowPaint = Paint()
      ..color = Colors.red
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(shadowPath, shadowPaint);

    // 绘制原图（平移不缩放）
    final moveOffsetX = size.width * 0.05; // 可调整偏移量
    final moveOffsetY = size.height * 0.05;
    canvas.save();
    canvas.translate(moveOffsetX, moveOffsetY);
    final originalPath = _createWavePath(size, offset);
    final originalPaint = Paint()..color = Colors.pink[200]!;
    // 创建圆形路径用于限制粉色部分为圆形
    final innerCirclePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: (size.width / 2) - max(moveOffsetX, moveOffsetY)));
    canvas.clipPath(innerCirclePath);
    canvas.drawPath(originalPath, originalPaint);
    canvas.restore();
  }

  Path _createWavePath(Size size, double offset) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    for (double x = 0; x < size.width; x += 1) {
      final y = size.height * 0.5 +
          10 * sin((x / size.width * 2 * pi) + offset * 2 * pi);
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _WaveShadowPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

// 使用示例
class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MovingWaveShadowWidget(),
      ),
    );
  }
}
    