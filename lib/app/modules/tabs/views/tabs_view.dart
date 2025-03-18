/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:46:31
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:15:54
 * @FilePath: /my_flutter_template_getx/lib/app/modules/tabs/views/tabs_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_flutter_template_getx/app/core/utils/screen_adapter.dart';
import 'package:my_flutter_template_getx/app/core/values/app_colors.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return 
    // Obx(() => 
    Scaffold(
          body: PageView(
            // key: GlobalKey<ScaffoldState>(), // 每次创建新实例
            physics: NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              // controller.setCurrentIndex(index);
            },
          ),
    //       bottomNavigationBar: Theme(
    //         data: Theme.of(context).copyWith(
    //            splashFactory: NoSplash.splashFactory, // 禁用水波纹
    // highlightColor: Colors.transparent,    // 禁用点击时的高亮效果
    // splashColor: Colors.transparent,       // 禁用点击时的水波纹颜色
    //         ),
    //         child: BottomNavigationBar(
    //         enableFeedback: false,
            
    //         fixedColor: AppColors.Color999, //选中的颜色
    //         unselectedItemColor: AppColors.Color999, // 未选中时的颜色
    //         selectedLabelStyle: TextStyle(
    //           fontSize: ScreenAdapter.fontSize(10), // 选中时的字体大小
    //           height: ScreenAdapter.fontSize(14 / 10.0),
    //         ),
    //         unselectedLabelStyle: TextStyle(
    //           fontSize: ScreenAdapter.fontSize(10), // 选中时的字体大小
    //           height: ScreenAdapter.fontSize(14 / 10.0),
    //         ),
    //         currentIndex: controller.currentIndex.value, //第几个菜单选中
    //         type: BottomNavigationBarType.fixed, //如果底部有4个或者4个以上的
    //         onTap: (index) {
    //           controller.setCurrentIndex(index);
    //           controller.pageController.jumpToPage(index);
              
    //         },
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: controller.currentIndex.value == 0
    //                 ? Icon(Icons.home,size: ScreenAdapter.height(30),)
    //                 : Icon(Icons.home_outlined,size: ScreenAdapter.height(30),),
    //             label: "Home",
    //           ),
    //           BottomNavigationBarItem(
    //             icon: controller.currentIndex.value == 1
    //                 ? Icon(Icons.home,size: ScreenAdapter.height(30),)
    //                 : Icon(Icons.home_outlined,size: ScreenAdapter.height(30),),
    //             label: "User",
    //           ),
             
    //         ],
    //       ),
    //       )
        
        )
        // )
        ;
 
 
  }


}
