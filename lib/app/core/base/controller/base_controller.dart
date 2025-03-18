/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:18:54
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 21:16:38
 * @FilePath: /flutter_liquid/lib/app/core/base/controller/base_controller.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter_liquid/app/core/utils/logger_singleton.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logger/logger.dart';



/**
 * 封装基础控制器
 * 1、日志
 * 2、国际化
 * 3、刷新页面
 * 4、页面状态管理
 * 5、加载提示
 * 6、显示消息框
 */
abstract class BaseController extends GetxController {

  // 获取 logger 单例
  final Logger logger = LoggerSingleton.getInstance();







  

  @override
  void onClose() {

    super.onClose();
  }
}