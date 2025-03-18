/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-13 15:20:06
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 21:16:52
 * @FilePath: /flutter-template-getx/lib/app/core/base/view/base_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liquid/app/core/base/controller/base_controller.dart';
import 'package:flutter_liquid/app/core/utils/screen_adapter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';


abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  final Color bgColor;
  Color? headColr;
  final Widget? banner;
  final Widget? bgBanner;
  final Widget? bgIcon;
  bool headAll;


  /**
   * @description: 页面内边距
   * @return {*}
   */
  final EdgeInsets parentPaddings;
  
  /**
   * @description: 
   * 1、打开 Drawer（侧边栏）；
   * 2、显示 SnackBar/BottomSheet；
   * 3、控制 AppBar 的折叠状态；
   * 4、访问 Scaffold 的其他功能；
   * @return {*}
   */
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  BaseView(
      {super.key,
      required this.parentPaddings,
      required this.bgColor,
      this.banner,
      this.bgBanner,
      this.headAll = false,
      this.headColr = Colors.white,
      this.bgIcon});
  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    // behavior: HitTestBehavior.translucent,
    // child:
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // annotatedRegion(context),
        pageScaffold(context),
        // Obx(() => controller.pageState == PageState.LOADING
        //     ? shadowBox()
        //     : Container()),
        // Obx(() => controller.pageState == PageState.LOADING
        //     ? _showLoading(controller.loadingMessage)
        //     : Container()),

        // Obx(() => controller.errorMessage.isNotEmpty
        //     ? showErrorSnackBar(controller.errorMessage)
        //     : Container()),
        // 其他组件
        // if (banner != null) banner!, // 检查 banner 是否为 null，然后添加到 children 列表中
      ],
    );
    // )
  }

  //自定义标题栏样式
  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      //sets ios status bar color
      backgroundColor: headColr,
      key: globalKey,
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      body: pageContent(context),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: drawer(),
    );
  }

  Widget pageContent(BuildContext context) {
    //SafeArea 是 Flutter 提供的一个组件，用于确保其子组件在不受设备状态栏、底部导航栏和其他系统UI元素干扰的安全区域内显示。它会自动适应设备，并确保内容不会被遮挡。
    return Stack(
      clipBehavior: headAll ? Clip.hardEdge : Clip.none,
      children: [
        // 这个 Banner 不受 SafeArea 限制，能从状态栏开始显示
        if (bgBanner != null) bgBanner!,
        if (bgIcon != null) bgIcon!,

        // 下面的内容使用 SafeArea 避免遮挡
        SafeArea(
          child: Container(
            width: ScreenAdapter.width(375),
            // height: ScreenAdapter.height(812),
            padding: parentPaddings,
            color: bgColor,
            child: body(context),
          ),
        ),
      ],
    );
    // return body(context);
  }

  /**
   * @description: ：用于显示浮动操作按钮，通常位于页面的右下角，用于执行主要操作。
   * @return {*}
   */  
  Widget? floatingActionButton() {
    return null;
  }

  /**
   * @description: 用于显示底部导航栏，通常包含多个图标或文本项，用于在不同页面或功能之间切换。
   * @return {*}
   */  
  Widget? bottomNavigationBar() {
    return null;
  }

  /**
   * @description: 用于显示侧边栏，通常通过在屏幕边缘滑动或点击应用栏上的菜单图标来打开。
   * @return {*}
   */  
  Widget? drawer() {
    return null;
  }
}


