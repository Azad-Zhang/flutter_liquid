/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-13 16:31:05
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-13 16:31:12
 * @FilePath: /flutter-template-getx/lib/app/core/utils/screen_adapter.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter{

  static width(num v){
    return v.w;
  }
  static height(num v){
    return v.h;
  }
  static fontSize(double v){
    return v.sp;
  }
  static getScreenWidth(num v){
    // return ScreenUtil().screenWidth;
    return 1.sw;
  }
  static getScreenHeight(num v){
    // return ScreenUtil().screenHeight;
    return 1.sh;
  }
  static getStatusBarHeight(){
    return ScreenUtil().statusBarHeight;
  }
}