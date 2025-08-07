import 'package:aioniq/app/modules/home/controllers/home_controller.dart';
import 'package:aioniq/app/modules/ip_setting/controllers/ip_controller.dart';
import 'package:aioniq/app/constant/app_colors.dart';
import 'package:aioniq/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeaderWidget extends GetView<HomeController> {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final IpController ipController = Get.find<IpController>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Aionq',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.IP);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Icon(
                    Icons.wifi, // ikon bebas, bisa diganti
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Obx(() {
            final ip = ipController.ip.value;
            return Text(
              'Aplikasi ini berjalan pada server: $ip',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ],
      ),
    );
  }
}

//import 'package:akuabot/app/modules/home/controllers/home_controller.dart';
//import 'package:akuabot/app/routes/app_pages.dart';
//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//
//class HomeHeaderWidget extends GetView<HomeController> {
//  const HomeHeaderWidget({super.key});
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//          const Text(
//            'AIONIQ',
//            style: TextStyle(
//                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//          ),
//          Row(
//            children: [
//              // Tombol IP Server
//              GestureDetector(
//                onTap: () {
//                  Get.toNamed(Routes.IP);
//                },
//                child: Container(
//                  width: 30,
//                  height: 30,
//                  decoration: BoxDecoration(
//                    color: Colors.white.withOpacity(0.3),
//                    borderRadius: BorderRadius.circular(99),
//                  ),
//                  child: const Icon(
//                    Icons.wifi, // ikon bebas, bisa diganti
//                    color: Colors.white,
//                    size: 20,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
