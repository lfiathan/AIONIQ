import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:http/http.dart' as http;

class ScheduleController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;

  // Simpan schedules dari API
  RxList<Map<String, dynamic>> schedulesController = <Map<String, dynamic>>[].obs;

  final String baseUrl = 'http://localhost:3000/api'; // Ganti sesuai alamat API lokal kamu
  final String userId = 'testing'; // Sesuaikan dengan user id login

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/feedSchedules/$userId'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        schedulesController.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Gagal mengambil jadwal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  Future<void> changeIsActive(String id, bool isActive) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/feedSchedules/$userId/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isActive': isActive}),
      );
      if (response.statusCode == 200) {
        // Update lokal setelah sukses
        int index = schedulesController.indexWhere((e) => e['id'] == id);
        if (index != -1) {
          schedulesController[index]['isActive'] = isActive;
          schedulesController.refresh();
        }
      } else {
        Get.snackbar('Error', 'Gagal mengubah status jadwal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  // Method baru untuk update jadwal (tanggal dan waktu)
  Future<bool> updateSchedule(String id, String newScheduleIso) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/feedSchedules/$userId/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'schedule': newScheduleIso}),
      );
      if (response.statusCode == 200) {
        // Update data lokal supaya UI langsung refresh
        int index = schedulesController.indexWhere((e) => e['id'] == id);
        if (index != -1) {
          schedulesController[index]['schedule'] = newScheduleIso;
          schedulesController.refresh();
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Kirim request siram tanaman sekarang ke API
  Future<void> waterNow() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/watering'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Tanaman telah disiram", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal menyiram tanaman");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // Kirim request beri pakan sekarang ke API
  Future<void> feedNow() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/feeding'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Pakan telah diberikan", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal memberi pakan");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  List<HawkFabMenuItem> fabMenu(BuildContext context) => [
    HawkFabMenuItem(
      heroTag: 'menu1',
      label: 'Siram tanaman sekarang',
      ontap: () {
        Get.dialog(
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Dialog(
                insetPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.05,
                    horizontal: Get.width * 0.05,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/schedule/watering_plant.png",
                        height: Get.height * 0.3,
                        width: Get.height * 0.3,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Siram tanaman sekarang?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: Get.height * 0.15,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xff334893),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(
                                  color: Color(0xff334893),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.height * 0.15,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xff334893),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await waterNow();
                                Get.back();
                              },
                              child: const Text(
                                "Ya",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      icon: const Icon(
        Icons.energy_savings_leaf_outlined,
        color: Colors.white,
      ),
      color: const Color(0xff334893),
      labelColor: const Color(0xff334893),
    ),
    HawkFabMenuItem(
      heroTag: 'menu3',
      label: 'Beri pakan sekarang',
      ontap: () {
        Get.dialog(
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Dialog(
                insetPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.05,
                    horizontal: Get.width * 0.05,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/schedule/feeding_fish.png",
                        height: Get.height * 0.3,
                        width: Get.height * 0.3,
                      ),
                      const Text(
                        "Beri pakan sekarang?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: Get.height * 0.15,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xff334893),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(
                                  color: Color(0xff334893),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.height * 0.15,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xff334893),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await feedNow();
                                Get.back();
                              },
                              child: const Text(
                                "Ya",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      icon: const Icon(
        Icons.food_bank_outlined,
        color: Colors.white,
      ),
      color: const Color(0xff334893),
      labelColor: const Color(0xff334893),
    ),
  ];
}
