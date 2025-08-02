import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offNamed(Routes.NAVBAR);
    });
    super.onInit();
  }
}
