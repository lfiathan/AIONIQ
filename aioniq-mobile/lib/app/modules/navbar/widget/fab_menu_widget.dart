// lib/app/modules/navbar/widget/fab_menu_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import '../../../constant/app_colors.dart';
import '../../schedule/controllers/schedule_controller.dart';

List<HawkFabMenuItem> fabMenu(BuildContext context) {
  final controller = Get.find<ScheduleController>();

  return [
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
                              border:
                                  Border.all(color: const Color(0xff334893)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(color: Color(0xff334893)),
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
                                await controller.waterNow();
                                Get.back();
                              },
                              child: const Text(
                                "Ya",
                                style: TextStyle(color: Colors.white),
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
      icon: const Icon(Icons.energy_savings_leaf_outlined, color: Colors.white),
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
                      const SizedBox(height: 15),
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
                              border:
                                  Border.all(color: const Color(0xff334893)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(color: Color(0xff334893)),
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
                                await controller.feedNow();
                                Get.back();
                              },
                              child: const Text(
                                "Ya",
                                style: TextStyle(color: Colors.white),
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
      icon: const Icon(Icons.food_bank_outlined, color: Colors.white),
      color: const Color(0xff334893),
      labelColor: const Color(0xff334893),
    ),
  ];
}

