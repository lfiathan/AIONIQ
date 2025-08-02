import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:akuabot/app/data/models/home_model.dart';
import 'package:akuabot/app/modules/ip_setting/controllers/ip_controller.dart';
import 'package:akuabot/app/data/mock_data.dart';

// ... import yang sudah ada tetap sama

class HomeController extends GetxController {
  final IpController ipController = Get.find<IpController>();
  String get baseUrl => ipController.baseUrl;

  final bool isMockMode = true; // Set true to use mock data

  RxList<HomeModel> homeList = <HomeModel>[].obs;
  RxList<Map<String, dynamic>> schedulesController =
      <Map<String, dynamic>>[].obs;
  RxInt feedDuration = 0.obs;
  RxBool isButtonDisabled = false.obs;
  RxInt pakanStatus = 0.obs;
  RxInt siramStatus = 0.obs;

  Timer? dataTimer;

  final double humidityThreshold = 45.0;
  final double qualityThreshold = 1000.0;
  final double phThreshold = 7.0;
  final double tempThreshold = 22.0;
  final double amoniaThreshold = 0.200;

  @override
  void onInit() {
    super.onInit();
    if (isMockMode) {
      print('App is in mock mode. Fetching initial mock data.');
      fetchMockData();
    } else {
      print('App is in live mode. Fetching initial data from server.');
      fetchAllData();
      startAutoUpdate();
    }
    ever(ipController.ip, (_) {
      if (!isMockMode) {
        fetchAllData(); // Ambil ulang data saat IP berubah
        fetchJadwalPakan(); // Ambil ulang saat IP berubah
      }
    });
  }

  @override
  void onClose() {
    dataTimer?.cancel();
    super.onClose();
  }

  void fetchMockData() {
    fetchSensorData();
    fetchJadwalPakan();
    fetchPakanStatus();
    fetchSiramStatus();
  }

  void startAutoUpdate() {
    dataTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      fetchAllData();
    });
  }

  void fetchAllData() {
    fetchSensorData();
    fetchPakanStatus();
    fetchSiramStatus();
  }

  // ------------------ Sensor Fetching ------------------ //

  Future<void> fetchSensorData() async {
    if (isMockMode) {
      final mockData = mockSensorData();
      addDataToHomeModel(mockData);
      //homeList.refresh();
      print('Using mock sensor data for UI development.');
      return; // Exit the method
    }
    try {
      final endpoints = {
        'ph': '/api/value/ph',
        'kelembaban': '/api/value/kelembaban',
        'nutrisi': '/api/value/nutrisi',
        'suhu': '/api/value/suhu',
        'amonia': '/api/value/amonia',
      };

      Map<String, dynamic> sensorData = {};

      for (var key in endpoints.keys) {
        final response = await http.get(Uri.parse('$baseUrl${endpoints[key]}'));

        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          if (decoded['status'] == true &&
              decoded['data'] != null &&
              decoded['data'].isNotEmpty) {
            final value = decoded['data'][0];
            sensorData[key] = value[key];
          } else {
            sensorData[key] = null;
          }
        } else {
          sensorData[key] = null;
        }
      }

      addDataToHomeModel(sensorData);
      checkThresholds(sensorData);
      homeList.refresh();
    } catch (e) {
      print('Error saat fetchSensorData: $e');
    }
  }

  // ------------------ Status Fetching ------------------ //

  Future<void> fetchPakanStatus() async {
    if (isMockMode) {
      pakanStatus.value = 1; // 1 for active, 0 for inactive
      print('Using mock pakan status for UI development.');
      return;
    }
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/pakan/get'));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['status'] == true &&
            decoded['data'] != null &&
            decoded['data'].isNotEmpty &&
            decoded['data'][0]['stat'] != null) {
          pakanStatus.value = decoded['data'][0]['stat'];
        }
      }
    } catch (e) {
      print("Error fetchPakanStatus: $e");
    }
  }

  Future<void> fetchSiramStatus() async {
    if (isMockMode) {
      siramStatus.value = 0; // 1 for active, 0 for inactive
      print('Using mock siram status for UI development.');
      return;
    }
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/siram/get'));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['status'] == true &&
            decoded['data'] != null &&
            decoded['data'].isNotEmpty &&
            decoded['data'][0]['stat'] != null) {
          siramStatus.value = decoded['data'][0]['stat'];
        }
      }
    } catch (e) {
      print("Error fetchSiramStatus: $e");
    }
  }

  // ------------------ Schedule API ------------------ //

  Future<void> fetchJadwalPakan() async {
    if (isMockMode) {
      schedulesController.value = mockScheduleData();
      print('Using mock schedule data for UI development.');
      return; // Exit the method
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

  // ------------------ Status Update ------------------ //

  Future<void> updatePakanStatus(int status) async {
    if (isMockMode) {
      pakanStatus.value = status;
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/pakan/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': 1, 'stat': status}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          pakanStatus.value = data['data']['stat'];
        }
      }
    } catch (e) {
      print("Error updatePakanStatus: $e");
    }
  }

  Future<void> updateSiramStatus(int status) async {
    if (isMockMode) {
      siramStatus.value = status;
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/siram/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': 1, 'stat': status}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          siramStatus.value = data['data']['stat'];
        }
      }
    } catch (e) {
      print("Error updateSiramStatus: $e");
    }
  }

  // ------------------ Util ------------------ //

  void addDataToHomeModel(Map<String, dynamic> data) {
    homeList.clear();
    homeList.addAll([
      HomeModel(
        key: 'kelembaban',
        title: 'Kelembaban',
        value: data['kelembaban'] != null
            ? "${data['kelembaban'].toStringAsFixed(1)} %"
            : "-",
        image: 'assets/images/home_icons/humidity.png',
      ),
      HomeModel(
        key: 'ph',
        title: 'pH Air',
        value: data['ph'] != null ? data['ph'].toStringAsFixed(2) : "-",
        image: 'assets/images/home_icons/ph.png',
      ),
      HomeModel(
        key: 'kualitasAir',
        title: 'Kualitas Air',
        value: data['nutrisi'] != null
            ? "${data['nutrisi'].toStringAsFixed(0)} PPM"
            : "-",
        image: 'assets/images/home_icons/water_quality.png',
      ),
      HomeModel(
        key: 'temperatur',
        title: 'Temperatur',
        value: data['suhu'] != null
            ? "${data['suhu'].toStringAsFixed(1)} °C"
            : "-",
        image: 'assets/images/home_icons/temperature.png',
      ),
      HomeModel(
        key: 'amonia',
        title: 'Kadar Amonia',
        value: data['amonia'] != null
            ? "${data['amonia'].toStringAsFixed(3)} mg/l"
            : "-",
        image: 'assets/images/home_icons/nh3_icon.png',
      ),
    ]);
  }

  void checkThresholds(Map<String, dynamic> data) {
    if (!isMockMode) {
      if (data['kelembaban'] != null &&
          data['kelembaban'] < humidityThreshold) {
        Get.snackbar(
          "Peringatan Kelembaban",
          "Kelembaban udara rendah (${data['kelembaban'].toStringAsFixed(1)}%). Segera siram tanaman!",
          backgroundColor: const Color(0xffFFCDD2),
          colorText: const Color(0xffB71C1C),
        );
      }
      if (data['nutrisi'] != null && data['nutrisi'] < qualityThreshold) {
        Get.snackbar("Peringatan Kualitas Air",
            "Kualitas air rendah (${data['nutrisi'].toStringAsFixed(0)} PPM)");
      }
      if (data['ph'] != null && data['ph'] < phThreshold) {
        Get.snackbar("Peringatan pH Air",
            "pH air terlalu rendah (${data['ph'].toStringAsFixed(2)})");
      }
      if (data['suhu'] != null && data['suhu'] < tempThreshold) {
        Get.snackbar("Peringatan Temperatur",
            "Suhu air rendah (${data['suhu'].toStringAsFixed(1)}°C)");
      }
      if (data['amonia'] != null && data['amonia'] > amoniaThreshold) {
        // <-- Logika amonia
        Get.snackbar(
          "Peringatan Amonia",
          "Kadar amonia terlalu tinggi (${data['amonia'].toStringAsFixed(3)} mg/l).",
          backgroundColor: const Color(0xffFFCDD2),
          colorText: const Color(0xffB71C1C),
        );
      }
    }
  }

  String getSensorValue(String key) {
    final item = homeList.firstWhereOrNull((e) => e.key == key);
    return item?.value ?? '-';
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
