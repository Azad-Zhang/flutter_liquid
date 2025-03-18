/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:18:13
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:46:50
 * @FilePath: /my_flutter_template_getx/lib/app/modules/home/views/home_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_flutter_template_getx/app/core/base/view/base_view.dart';
import 'package:my_flutter_template_getx/app/core/utils/screen_adapter.dart';
import 'package:my_flutter_template_getx/app/core/values/app_colors.dart';
import 'package:my_flutter_template_getx/app/core/widgets/custom_app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({
    super.key,
  }) : super(
            parentPaddings: EdgeInsets.all(0),
            // parentPaddings: [0,0,0,0],
            // bgColor: AppColors.homeBgColor,
            // banner: HomeBanner(),
            bgColor: Colors.white);

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
      child: Text("HomeView is working"),
    );
  }
}
