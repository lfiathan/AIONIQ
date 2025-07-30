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
            'Apens-iot',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Row(
            children: [
              // Tombol FAQ
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FAQ);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              //Tombol Setting
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SETTING);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/home_icons/mini_icons.png',
                  ),
                ),
              ),

              const SizedBox(width: 10),

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
