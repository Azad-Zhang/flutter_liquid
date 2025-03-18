/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-18 14:18:13
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-18 15:35:42
 * @FilePath: /my_flutter_template_getx/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    // GetMaterialApp(
    //   title: "Application",
    //   initialRoute: AppPages.INITIAL,
    //   getPages: AppPages.routes,
    // ),
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return  GetMaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                  onPrimary: Colors.white, surfaceTint: Colors.transparent),
            ),
            debugShowCheckedModeBanner: false,
            // title: _envConfig.appName,
            title: "Application",
            initialRoute: AppPages.INITIAL,
            // initialBinding: InitialBinding(),
            defaultTransition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 200),
            getPages: AppPages.routes,
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            // locale: _appLocale, // 设置默认语言为英文
          );
      },
    )
  );
}
