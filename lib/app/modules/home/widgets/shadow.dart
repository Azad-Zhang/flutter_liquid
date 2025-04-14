import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';

// 定义一个常量的 Border 对象
const defaultBorder = Border.fromBorderSide(BorderSide(color: Colors.red, width: 1));

class MovingWaveShadowWidget extends StatefulWidget {
  final Gradient? originalGradient; // 阴影渐变色，改为可选参数
  final Color? shadowColor; // 新增阴影颜色参数，改为可选参数

  final Duration waveDuration; // 新增时长参数
  final double size;
  final double padding;
  final Border border;

  const MovingWaveShadowWidget({
    Key? key,
    this.originalGradient,
    this.shadowColor,
    this.waveDuration = const Duration(seconds: 2), // 默认 2 秒
    this.size = 100,
    this.padding = 10,
    this.border = defaultBorder,
  }) : assert((originalGradient != null && shadowColor == null) || (originalGradient == null && shadowColor != null),
            'originalGradient and shadowColor only one can be passed in'),
       super(key: key);

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
      duration: widget.waveDuration, // 使用外部传入的时长
      lowerBound: 0.0,    // 明确设置下限
      upperBound: 1.0,    // 设置无限循环的上限
    )..repeat();
    // 使用无限增长的动画值
    _offsetAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 1.0),
      
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
          width: widget.size,
          height: widget.size,
          padding: EdgeInsets.all(widget.padding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: widget.border,
          ),
          child: CustomPaint(
            painter: _WaveShadowPainter(
              _offsetAnimation.value,
              widget.originalGradient,
              widget.shadowColor, // 传递阴影颜色
            ),
          ),
        );
      },
    );
  }
}

class _WaveShadowPainter extends CustomPainter {
  final double offset;
  final Gradient? originalGradient;
  final Color? shadowColor; // 新增阴影颜色属性

  _WaveShadowPainter(this.offset, this.originalGradient, this.shadowColor);

  @override
  void paint(Canvas canvas, Size size) {
    final phase = offset % 1.0; // 使用模运算实现无限循环
    final path = _createWavePath(size, phase);

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final shadowPath = _createWavePath(size, offset);
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    if (originalGradient != null) {
      final paint = Paint()
        ..shader = originalGradient!.createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawPath(shadowPath, paint);
    } else if (shadowColor != null) {
      canvas.drawPath(shadowPath, Paint()..color = shadowColor!);
    }

    canvas.restore();
  }

  // 修改波形生成函数相位计算
  Path _createWavePath(Size size, double phase) {
    const waveHeight = 16.0;
    final baseY = size.height * 0.52;
    const horizontalPadding = 50.0;

    final path = Path();
    path.moveTo(-horizontalPadding, baseY);

    // 使用持续增长的相位值
    final waveFrequency = 3.5;
    for (double x = -horizontalPadding; x <= size.width + horizontalPadding; x++) {
      final radians = (x / size.width * waveFrequency * pi) + (phase * 2 * pi);
      final y = baseY + waveHeight * sin(radians);
      path.lineTo(x, y);
    }

    path.lineTo(size.width + horizontalPadding, size.height + 100);
    path.lineTo(-horizontalPadding, size.height + 100);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _WaveShadowPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.originalGradient != originalGradient || oldDelegate.shadowColor != shadowColor;
  }
}    