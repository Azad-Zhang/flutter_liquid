/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:18:13
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:46:50
 * @FilePath: /flutter_liquid/lib/app/modules/home/views/home_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/modules/home/widgets/liquid.dart';

import 'package:get/get.dart';
import 'package:flutter_liquid/app/core/base/view/base_view.dart';
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';
import 'package:flutter_liquid/app/core/values/app_colors.dart';
import 'package:flutter_liquid/app/core/widgets/custom_app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({
    super.key,
  }) : super(
            parentPaddings: EdgeInsets.all(0),
            // parentPaddings: [0,0,0,0],
            // bgColor: AppColors.homeBgColor,
            // banner: HomeBanner(),
            bgColor: Color.fromRGBO(27, 107, 255, 0.07));

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Home",
      customHeight: ScreenAdapter.height(44),
      appBarColor: Colors.white,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Wrap(
      spacing: 10, // 水平间距
      runSpacing: 10, // 垂直间距
      children: List.generate(10, (index) {
        return LiquidBall(
          size: 100,
          borderColor: Color.fromRGBO(255, 129, 129, 1),
          // waveSingleColor: Colors.red,
          waveGradientColor: LinearGradient(
            colors: [
              Color.fromRGBO(255, 151, 151, 1),
              Color.fromRGBO(255, 44, 44, 1)
            ],
          ),
          padding: EdgeInsets.all(4),
          percentage: index * 10,
          // waveSpeed: 2.0, // 波浪速度变为原来的 2 倍
          waveHeightFactor: 0.1, // 波浪高度变为原来的 2 倍
          waveSpeed: 1.0, // 波浪左右滚动速度变为原来的 2 倍
          // waveHeightFactor: 0.2, // 波浪高度变为原来的 2 倍
          waveRiseSpeed: 1, // 波浪升起速度变为原来的 0.5 倍
          // borderWidth: 1,
          // isWaveAmplitudeRandom: true,
        );
      }),
    );
  }
}
