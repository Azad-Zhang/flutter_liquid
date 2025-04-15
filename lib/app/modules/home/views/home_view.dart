/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-19 10:27:01
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-04-15 15:55:52
 * @FilePath: /my_flutter_template_getx/lib/app/modules/home/views/home_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:18:13
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-20 16:52:58
 * @FilePath: /flutter_liquid/lib/app/modules/home/views/home_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/modules/home/widgets/liquid_ball.dart';


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
    return Center(
      child: LiquidBallWidget(
        waveGradient: LinearGradient(
          colors: [
            Color(0xFFFF9797),
            Color(0xFFFF2C2C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        containerPadding: 10,
        containerBorder: Border.all(color: Color(0xFFFF8181)),
        containerSize: 200, 
        percentage: 0.5,
        // shadowColor: Colors.red,
      ),
    );
  }
}
