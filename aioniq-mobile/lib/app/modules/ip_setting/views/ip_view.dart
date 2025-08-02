import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import '../controllers/ip_controller.dart';
import '../../home/controllers/home_controller.dart';

class SetIpView extends StatelessWidget {
  SetIpView({super.key});

  final IpController ipController = Get.find<IpController>();
  final TextEditingController ipTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (ipTextController.text.isEmpty) {
      ipTextController.text = ipController.ip.value;
    }

    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  const Text(
                    'Ubah IP Server',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.transparent),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Body Container
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: ipTextController,
                              keyboardType: TextInputType.url,
                              decoration: const InputDecoration(
                                labelText: 'Alamat IP Server',
                                hintText: 'contoh: http://192.168.1.100:3000',
                                border: OutlineInputBorder(),
                                labelStyle:
                                    TextStyle(color: AppColors.darkerBlue),
                              ),
                              style:
                                  const TextStyle(color: AppColors.darkerBlue),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final ipInput = ipTextController.text.trim();

                                  if (!ipInput.startsWith('http://') &&
                                      !ipInput.startsWith('https://')) {
                                    Get.snackbar(
                                      'Error',
                                      'Alamat IP harus diawali dengan http:// atau https://',
                                      backgroundColor: Colors.red[100],
                                      colorText: Colors.black,
                                    );
                                    return;
                                  }

                                  await ipController.saveIp(ipInput);

                                  if (Get.isRegistered<HomeController>()) {
                                    final homeController =
                                        Get.find<HomeController>();
                                    homeController.fetchAllData();
                                  }

                                  Get.snackbar(
                                    'Berhasil',
                                    'Aplikasi ini sekarang berjalan pada server:\n$ipInput',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green[100],
                                    colorText: Colors.black,
                                    margin: const EdgeInsets.all(16),
                                    duration: const Duration(seconds: 4),
                                    borderRadius: 10,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1A3C40),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Simpan IP',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
