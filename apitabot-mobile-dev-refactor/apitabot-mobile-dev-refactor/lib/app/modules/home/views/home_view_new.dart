import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akuabot/app/modules/home/controllers/home_controller.dart';
import 'package:akuabot/app/modules/ip_setting/controllers/ip_controller.dart';
import 'package:akuabot/app/modules/home/widgets/home_header_widget.dart';
import 'package:akuabot/app/modules/home/widgets/build_schedules_widget.dart';
import 'package:akuabot/app/routes/app_pages.dart';

class HomeViewNew extends GetView<HomeController> {
  const HomeViewNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IpController ipController = Get.find<IpController>();

    return Scaffold(
      backgroundColor: const Color(0xffF0F9EE),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: Get.width,
              child: Image.asset(
                'assets/images/home/background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // HEADER + Running Text
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final ip = ipController.ip.value;
                  return Container(
                    width: double.infinity,
                    color: const Color(0xff1A3C40),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'Aplikasi ini berjalan pada server: $ip',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/home/homepage_header.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        const HomeHeaderWidget(),
                        _sectionTitle('Status Sensor'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff000000).withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  if (controller.homeList.isEmpty) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  final sensorItems = [
                                    {
                                      'icon': 'assets/images/home_icons/humidity.png',
                                      'title': 'Kelembaban',
                                      'value': controller.getSensorValue('kelembaban'),
                                    },
                                    {
                                      'icon': 'assets/images/home_icons/ph.png',
                                      'title': 'pH Air',
                                      'value': controller.getSensorValue('ph'),
                                    },
                                    {
                                      'icon': 'assets/images/home_icons/water_quality.png',
                                      'title': 'Kualitas Air',
                                      'value': controller.getSensorValue('kualitasAir'),
                                    },
                                    {
                                      'icon': 'assets/images/home_icons/temperature.png',
                                      'title': 'Suhu Air',
                                      'value': controller.getSensorValue('temperatur'),
                                    },
                                  ];
                                  return Column(
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: sensorItems.length,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 3.5,
                                        ),
                                        itemBuilder: (context, index) {
                                          final item = sensorItems[index];
                                          return _buildSensorTile(
                                            item['icon']!,
                                            item['title']!,
                                            item['value']!,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.EDUCATION);
                                        },
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Pelajari Lebih Lanjut',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff60AB4D),
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _sectionTitle('Penjadwalan Pakan'),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: BuildSchedulesWidget(),
                        ),
                        _sectionTitle('Aksi Cepat'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: _buildQuickActions(constraints),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff4D4D4D),
        ),
      ),
    );
  }

  List<Widget> _buildQuickActions(BoxConstraints constraints) {
    return [
      _buildQuickAction('Pemberian Pakan', 'Pemberian pakan secara manual',
          'assets/images/home_icons/fish_icon.png', 'feed', constraints),
      const SizedBox(height: 10),
      _buildQuickAction('Penyemprotan Air', 'Penyemprotan air secara manual',
          'assets/images/home_icons/plant_icon.png', 'water', constraints),
    ];
  }

  Widget _buildQuickAction(String title, String subtitle, String icon,
      String actionType, BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image.asset(icon, width: 30, height: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 9, color: Colors.grey)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (actionType == 'feed') {
                await controller.updatePakanStatus(1);
              } else if (actionType == 'water') {
                await controller.updateSiramStatus(1);
              }

              Get.dialog(
                barrierDismissible: false,
                Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          actionType == 'feed'
                              ? 'assets/gif/fish.gif'
                              : 'assets/gif/plant.gif',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sedang melakukan aksi...',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            if (actionType == 'feed') {
                              await controller.updatePakanStatus(0);
                            } else if (actionType == 'water') {
                              await controller.updateSiramStatus(0);
                            }
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xff60AB4D),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xff60AB4D),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Lakukan',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSensorTile(String iconPath, String title, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                Text(value,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
