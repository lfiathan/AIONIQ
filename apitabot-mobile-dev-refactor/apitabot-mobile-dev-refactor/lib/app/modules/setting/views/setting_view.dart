import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: Get.width,
              child: Image.asset(
                'assets/images/home/homepage_header.png',
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Tentang Apens-iot',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.07),
                      blurRadius: 15,
                      offset: const Offset(-1, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/about/Design Apens-iot Page (Tentang Apens-iot).png'),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                width: Get.width,
                height: Get.height * 0.3,
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        controller.launchInBrowser(
                          Uri.parse(
                            'https://api.whatsapp.com/send/?phone=6289681149655&text=Halo+Apitabot%2C+saya+ingin+bertanya+tentang+produk+anda.&type=phone_number&app_absent=0',
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
                              color: const Color(0xff000000).withOpacity(0.05),
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
                                color: const Color(0xff69A31A).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(99),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff000000).withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.phone,
                                color: Color(0xff69A31A),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Hubungi Customer Service (WA)',
                              style: TextStyle(
                                color: Color(0xff4D4D4D),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.launchInBrowser(
                          Uri.parse(
                            'https://api.whatsapp.com/send/?phone=6289681149655&text=Halo+Apitabot%2C+saya+ingin+memberikan+saran+dan+masukan+tentang+produk+anda.&type=phone_number&app_absent=0',
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
                              color: const Color(0xff000000).withOpacity(0.05),
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
                                color: const Color(0xff69A31A).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(99),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff000000).withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.mail,
                                color: Color(0xff69A31A),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Saran dan Masukan',
                              style: TextStyle(
                                color: Color(0xff4D4D4D),
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
            ],
          ),
        ],
      ),
    );
  }
}
