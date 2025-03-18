import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_liquid/app/modules/home/views/home_view.dart';

class TabsController extends GetxController {

  RxInt currentIndex = 0.obs;
  PageController pageController = Get.arguments != null
      ? PageController(initialPage: Get.arguments["initialPage"])
      : PageController(initialPage: 0);

  final List<Widget> pages = [
    HomeView(),
    // UserView()
  ];

      
  @override
  void onInit() {
    super.onInit();
  }

    /**
   * @description: Set bottom navigation index
   * @return {*}
   */
  void setCurrentIndex(index) {
    currentIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;
}
