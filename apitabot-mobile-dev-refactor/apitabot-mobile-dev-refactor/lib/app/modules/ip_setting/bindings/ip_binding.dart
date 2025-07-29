import 'package:get/get.dart';
import '../controllers/ip_controller.dart';

class IpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IpController>(() => IpController());
  }
}
