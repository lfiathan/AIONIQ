import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import '../../../routes/app_pages.dart';
import 'package:akuabot/app/modules/ip_setting/controllers/ip_controller.dart';
import 'package:http/http.dart' as http;

class NavbarController extends GetxController {
  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);
  // --- FIX: Tambahkan variabel yang hilang di sini ---
  final IpController ipController = Get.find<IpController>();
  String get baseUrl => ipController.baseUrl;
  final String userId = 'testing'; // Tambahkan variabel userId
  // --------------------------------------------------

  List<PersistentTabConfig> tabs() => [
        PersistentTabConfig(
          screen: GetRouterOutlet(initialRoute: Routes.HOME),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Beranda",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: const Color(0xff334893),
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.HOME,
            routes: {
              Routes.HOME: (context) => GetRouterOutlet(
                    initialRoute: Routes.HOME,
                  ),
            },
          ),
        ),
        PersistentTabConfig(
          screen: GetRouterOutlet(
            initialRoute: Routes.SCHEDULE,
          ),
          item: ItemConfig(
            icon: const Icon(Icons.alarm),
            title: "Jadwal",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: const Color(0xff334893),
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.SCHEDULE,
            routes: {
              Routes.SCHEDULE: (context) => GetRouterOutlet(
                    initialRoute: Routes.SCHEDULE,
                  ),
            },
          ),
        ),
        PersistentTabConfig(
          screen: GetRouterOutlet(
            initialRoute: Routes.FAQ,
          ),
          item: ItemConfig(
            icon: const Icon(Icons.question_answer),
            title: "FAQ",
            activeForegroundColor: CupertinoColors.white,
            activeColorSecondary: const Color(0xff334893),
            inactiveForegroundColor: CupertinoColors.systemGrey,
            inactiveBackgroundColor: CupertinoColors.white,
          ),
          navigatorConfig: NavigatorConfig(
            initialRoute: Routes.FAQ,
            routes: {
              Routes.FAQ: (context) => GetRouterOutlet(
                    initialRoute: Routes.FAQ,
                  ),
            },
          ),
        ),
      ];

  // Pindahkan kode waterNow() dan feedNow() ke dalam kelas ini
  // --------------------------------------------------
  // Kirim request siram tanaman sekarang ke API
  Future<void> waterNow() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/watering'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Tanaman telah disiram",
            backgroundColor: Colors.green, colorText: Colors.white);
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
        body: jsonEncode(
            {'userId': userId, 'schedule': DateTime.now().toIso8601String()}),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Pakan telah diberikan",
            backgroundColor: Colors.green, colorText: Colors.white);
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
