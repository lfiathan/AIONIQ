import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:http/http.dart' as http;

class ScheduleController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;

  // Simpan schedules dari API
  RxList<Map<String, dynamic>> schedulesController =
      <Map<String, dynamic>>[].obs;

  final String baseUrl =
      'http://localhost:3000/api'; // Ganti sesuai alamat API lokal kamu
  final String userId = 'testing'; // Sesuaikan dengan user id login

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/feedSchedules/$userId'));
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
}
