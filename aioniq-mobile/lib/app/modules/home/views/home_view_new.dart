import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akuabot/app/modules/home/controllers/home_controller.dart';
import 'package:akuabot/app/modules/ip_setting/controllers/ip_controller.dart';
import 'package:akuabot/app/routes/app_pages.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import 'package:akuabot/app/data/models/home_model.dart'; // Impor HomeModel

class HomeViewNew extends GetView<HomeController> {
  const HomeViewNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IpController ipController = Get.find<IpController>();

    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: Stack(
        children: [
          // Header background
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Get.width,
              height: Get.height * 0.2,
              decoration: const BoxDecoration(
                color: AppColors.normalBlue,
              ),
            ),
          ),
          // Konten Utama dengan latar belakang putih dan sudut melengkung
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Header Halaman
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AIONIQ',
                              style: Get.textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: AppColors.white),
                              onPressed: () {
                                Get.toNamed(Routes.IP);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          final ip = ipController.ip.value;
                          return Text(
                            'Aplikasi ini berjalan pada server: $ip',
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Colors.white70,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Kartu Status Sensor Utama
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('Status Sensor'),
                          const SizedBox(height: 10),
                          Obx(() {
                            if (controller.homeList.isEmpty) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final sensorItems = controller.homeList;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4, // Tampilkan 4 item utama
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, index) {
                                final item = sensorItems[index];
                                return _buildSensorCard(
                                    item.image, item.title, item.value);
                              },
                            );
                          }),
                          const SizedBox(height: 20),
                          // Kartu Kadar Amonia
                          Obx(() {
                            final amoniaItem = controller.homeList
                                .firstWhereOrNull((e) => e.key == 'amonia');
                            if (amoniaItem == null)
                              return const SizedBox.shrink();
                            return Center(
                              child: _buildSensorCard(
                                amoniaItem.image,
                                amoniaItem.title,
                                amoniaItem.value,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.EDUCATION);
                      },
                      child: const Text(
                        'Pelajari Lebih Lanjut',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkerBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String name) {
    return Text(
      name,
      style: Get.textTheme.titleLarge!.copyWith(
        color: AppColors.darkerBlue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSensorCard(String iconPath, String title, String value) {
    return Container(
      width: Get.width * 0.4,
      height: Get.width * 0.4,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: AppColors.normalBlue.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath,
              width: 40, height: 40, color: AppColors.normalBlue),
          const SizedBox(height: 10),
          Text(
            value,
            style: Get.textTheme.titleMedium!.copyWith(
              color: AppColors.darkerBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodySmall!.copyWith(
              color: AppColors.darkerBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
