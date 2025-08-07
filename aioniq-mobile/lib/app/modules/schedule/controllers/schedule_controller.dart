import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aioniq/app/data/mock_data.dart';
import 'package:aioniq/app/modules/ip_setting/controllers/ip_controller.dart';

class ScheduleController extends GetxController {
  final IpController ipController = Get.find<IpController>();
  String get baseUrl => ipController.baseUrl;
  final bool isMockMode = true;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxList<Map<String, dynamic>> schedulesController =
      <Map<String, dynamic>>[].obs;
  RxInt feedDuration = 0.obs;
  RxBool isButtonDisabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJadwalPakan();
  }
  // ------------------ Schedule API ------------------ //

  Future<void> fetchJadwalPakan() async {
    if (isMockMode) {
      schedulesController.value = mockScheduleData();
      print('Using mock schedule data for UI development.');
      return;
    }
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/schedule/get'));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['status'] == true && decoded['data'] != null) {
          final schedule = decoded['data'][0];
          schedulesController.value = [
            {
              'id': 1,
              'title': 'Jadwal Pagi',
              'schedule':
                  schedule['pagi']['tanggal'] + "T" + schedule['pagi']['jam'],
              'duration': schedule['pagi']['durasi'],
              'isActive': schedule['pagi']['status'],
            },
            {
              'id': 2,
              'title': 'Jadwal Siang',
              'schedule':
                  schedule['siang']['tanggal'] + "T" + schedule['siang']['jam'],
              'duration': schedule['siang']['durasi'],
              'isActive': schedule['siang']['status'],
            },
            {
              'id': 3,
              'title': 'Jadwal Malam',
              'schedule':
                  schedule['malam']['tanggal'] + "T" + schedule['malam']['jam'],
              'duration': schedule['malam']['durasi'],
              'isActive': schedule['malam']['status'],
            }
          ];
        }
      }
    } catch (e) {
      print("Error fetchJadwalPakan: $e");
    }
  }

  Future<void> updateJadwalPakan(
      int id, String slot, Map<String, dynamic> data) async {
    if (isMockMode) {
      print("Jadwal $slot berhasil diupdate (MOCK).");
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/schedule/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({...data, 'slot': slot}),
      );
      if (response.statusCode == 200) {
        print("Jadwal $slot berhasil diupdate.");
      } else {
        print("Gagal update jadwal: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updateJadwalPakan: $e");
    }
  }
  // ------------------ Schedule Update ------------------ //

  Future<bool> updateScheduleTime(int index, DateTime newDate) async {
    if (isMockMode) {
      if (index < 0 || index >= schedulesController.length) return false;
      schedulesController[index]['schedule'] = newDate.toIso8601String();
      schedulesController.refresh();
      return true;
    }
    if (index < 0 || index >= schedulesController.length) return false;
    schedulesController[index]['schedule'] = newDate.toIso8601String();
    schedulesController.refresh();
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  Future<bool> updateScheduleDuration(int index, int duration) async {
    if (isMockMode) {
      if (index < 0 || index >= schedulesController.length) return false;
      schedulesController[index]['duration'] = duration;
      schedulesController.refresh();
      return true;
    }
    if (index < 0 || index >= schedulesController.length) return false;
    schedulesController[index]['duration'] = duration;
    schedulesController.refresh();
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  Future<bool> updateScheduleActiveStatus(int index, bool isActive) async {
    if (isMockMode) {
      if (index < 0 || index >= schedulesController.length) return false;
      schedulesController[index]['isActive'] = isActive;
      schedulesController.refresh();
      return true;
    }
    if (index < 0 || index >= schedulesController.length) return false;
    schedulesController[index]['isActive'] = isActive;
    schedulesController.refresh();
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}
