import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // cek apakah user sudah login (misal dari local storage)
    // contoh dummy: kalau sudah ada userId set true
    if (userId.value.isNotEmpty) {
      isLoggedIn.value = true;
      Get.toNamed(Routes.NAVBAR);
    }
  }

  Future<void> signInWithGoogle(String googleToken) async {
    // Kirim token Google ke backend untuk verifikasi dan login
    final response = await http.post(
      Uri.parse('https://yourapi.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': googleToken}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      userId.value = data['uid']; // asumsikan backend kasih uid
      isLoggedIn.value = true;

      await scheduleCheck(userId.value);

      Get.toNamed(Routes.NAVBAR);
    } else {
      Get.snackbar('Login Failed', 'Could not login. Please try again.');
    }
  }

  Future<void> scheduleCheck(String uid) async {
    final response = await http.get(
      Uri.parse('https://yourapi.com/schedules/$uid'),
    );

    if (response.statusCode == 200) {
      var schedules = jsonDecode(response.body) as List<dynamic>;

      if (schedules.isEmpty) {
        await createInitialSchedules(uid);
      }
    } else {
      print('Failed to fetch schedules');
    }
  }

  Future<void> createInitialSchedules(String uid) async {
    List<Map<String, dynamic>> initialSchedules = [
      {
        'isActive': false,
        'schedule': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
      },
      {
        'isActive': false,
        'schedule': DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
      },
      {
        'isActive': false,
        'schedule': DateTime.now().add(const Duration(hours: 3)).toIso8601String(),
      },
    ];

    for (var schedule in initialSchedules) {
      final response = await http.post(
        Uri.parse('https://yourapi.com/schedules/$uid'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(schedule),
      );

      if (response.statusCode != 201) {
        print('Failed to create schedule: ${schedule['schedule']}');
      }
    }

    print("Tiga dokumen awal telah dibuat.");
  }
}
