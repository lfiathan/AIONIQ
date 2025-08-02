import 'package:akuabot/app/modules/home/controllers/home_controller.dart';
import 'package:akuabot/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeaderWidget extends GetView<HomeController> {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'AIONIQ',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              // Tombol IP Server
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
        ],
      ),
    );
  }
}
