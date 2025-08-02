import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import '../controllers/setting_controller.dart';
import 'package:akuabot/app/routes/app_pages.dart'; // Impor untuk Get.toNamed

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            // Header Halaman
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
                    'Tentang AIONIQ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  // Tombol kosong untuk menjaga keseimbangan
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Column(
                      children: [
                        // Bagian yang berisi gambar banner AIONIQ
                        Container(
                          width: Get.width,
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.07),
                                blurRadius: 15,
                                offset: const Offset(-1, 3),
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/about/AIONIQ-banner.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Konten kontak dan masukan
                        // Hubungi Customer Service
                        GestureDetector(
                          onTap: () async {
                            controller.launchInBrowser(
                              Uri.parse(
                                'https://api.whatsapp.com/send/?phone=6289681149655&text=Halo+AIONIQ%2C+saya+ingin+bertanya+tentang+produk+anda.&type=phone_number&app_absent=0',
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: Get.width * 0.9,
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.normalBlue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.phone,
                                    color: AppColors.normalBlue,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Hubungi Customer Service (WA)',
                                  style: TextStyle(
                                    color: AppColors.darkerBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10), // Spasi antar tombol
                        // Saran dan Masukan
                        GestureDetector(
                          onTap: () async {
                            controller.launchInBrowser(
                              Uri.parse(
                                'https://api.whatsapp.com/send/?phone=6289681149655&text=Halo+AIONIQ%2C+saya+ingin+memberikan+saran+dan+masukan+tentang+produk+anda.&type=phone_number&app_absent=0',
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: Get.width * 0.9,
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.normalBlue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.mail,
                                    color: AppColors.normalBlue,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Saran dan Masukan',
                                  style: TextStyle(
                                    color: AppColors.darkerBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

