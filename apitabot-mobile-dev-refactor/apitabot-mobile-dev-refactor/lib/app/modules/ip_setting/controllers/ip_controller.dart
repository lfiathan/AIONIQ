import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IpController extends GetxController {
  final ip = ''.obs;
  bool isInitialized = false;

  static IpController get to => Get.find<IpController>();

  @override
  void onInit() {
    super.onInit();
    loadIp();
  }

  Future<void> loadIp() async {
    if (!isInitialized) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      ip.value = prefs.getString('base_ip') ?? 'http://10.0.2.2:8000';
      isInitialized = true;
    }
  }

  Future<void> saveIp(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_ip', value);
    ip.value = value;
  }

  /// Getter sederhana untuk baseUrl langsung
  String get baseUrl => ip.value;

  /// Getter yang memastikan IP sudah diload, cocok untuk init data
  Future<String> getBaseUrl() async {
    if (!isInitialized) {
      await loadIp();
    }
    return ip.value;
  }
}
