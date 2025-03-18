/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:46:31
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:44:49
 * @FilePath: /flutter_liquid/lib/app/modules/tabs/bindings/tabs_binding.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:get/get.dart';
import 'package:flutter_liquid/app/modules/home/controllers/home_controller.dart';

import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    
  }
}
