/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-13 16:21:49
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 14:50:25
 * @FilePath: /flutter-template-getx/lib/app/core/values/app_colors.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColors {
  //主题色
  static const Color colorPrimary = Color(0xFF38686A);

  //默认背景颜色
  static const Color pageBackground = Color(0xFFFFFFFF);
  static Color elevatedContainerColorOpacity = Colors.grey.withOpacity(0.5);

  //基础颜色
  static const Color Color333 = Color(0XFF333333);
  static const Color Color444 = Color(0XFF444444);
  static const Color Color666 = Color(0XFF666666);
  static const Color Color999 = Color(0XFF999999);
}
