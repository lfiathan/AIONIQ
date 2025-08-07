import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';

import 'package:aioniq/app/modules/home/controllers/home_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
