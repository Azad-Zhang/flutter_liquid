/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2024-07-16 17:27:07
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:30:11
 * @FilePath: /RPM-APP-MASTER/lib/app/core/widget/custom_app_bar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_template_getx/app/core/utils/screen_adapter.dart';

import '/app/core/values/app_colors.dart';

//根据我们的应用程序设计定制的默认应用程序栏
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitleText;
  final List<Widget>? actions;
  final bool isBackButtonEnabled;
  final double? customHeight; // 用于接收外界传入的高度
  final PreferredSizeWidget? bottomWidget; // 新增参数
  final Color? appBarColor;
  final EdgeInsetsGeometry? margin; // 新增参数：传入的padding
  final Widget? leading; // 新增参数：自定义左侧返回按钮
  final bool isBottomSide;

  CustomAppBar(
      {Key? key,
      required this.appBarTitleText,
      this.actions,
      this.isBackButtonEnabled = true,
      this.customHeight, // 新增参数
      this.bottomWidget,
      this.appBarColor,
      this.margin,
      this.leading, // 新增参数
      this.isBottomSide = false})
      : super(key: key);

  @override
  Size get preferredSize {
    if (customHeight != null) {
      return Size.fromHeight(customHeight!); // 如果传入了高度参数，则使用传入的高度
    } else {
      return AppBar().preferredSize; // 否则使用原始的 AppBar 的 preferredSize
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ?? EdgeInsets.zero,
      // color:Colors.red,
      // color: appBarColor ?? AppColors.homeBgColor,
      decoration: BoxDecoration(
          border: isBottomSide
              ? Border(bottom: BorderSide(color: Color(0XFFD6D6D6), width: 0.2))
              : Border(
                  )),

      child: AppBar(
        // backgroundColor: Colors.red,
        clipBehavior: Clip.none,
        backgroundColor: appBarColor ?? AppColors.Color333,

        centerTitle: true,
        elevation: 0,
        // automaticallyImplyLeading: isBackButtonEnabled,
        automaticallyImplyLeading: false, // 禁用默认的返回按钮
        leading: leading ??
            (isBackButtonEnabled
                ? InkWell(
                    onTap: () {
                      Get.back();
                    },
                    splashColor: Colors.transparent, // 去除水波纹效果
                    highlightColor: Colors.transparent, // 去除高亮效果
                    child: SizedBox(
                      width: ScreenAdapter.width(24),
                      height: ScreenAdapter.height(24),
                      // child: Center(
                      //   // 使用 Center 小部件使 SVG 图片居中
                      //   child: SvgPicture.asset(
                      //     Assets.images.backIcon,
                      //     width: ScreenAdapter.width(8.97), // 调整宽度
                      //     height: ScreenAdapter.height(16.26), // 调整高度
                      //     fit: BoxFit.contain, // 确保图片按比例显示
                      //   ),
                      // ),
                    ),
                  )
                : null),
        actions: actions,
        iconTheme: const IconThemeData(color: AppColors.colorPrimary),
        title: Text( appBarTitleText),
        bottom: bottomWidget,
      ),
    );
  }
}
