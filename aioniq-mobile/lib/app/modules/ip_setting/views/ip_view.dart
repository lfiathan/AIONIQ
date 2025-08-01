import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ip_controller.dart';
import '../../home/controllers/home_controller.dart';

class SetIpView extends StatelessWidget {
  SetIpView({Key? key}) : super(key: key);

  final IpController ipController = Get.find<IpController>();
  final TextEditingController ipTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (ipTextController.text.isEmpty) {
      ipTextController.text = ipController.ip.value;
    }

    return Scaffold(
      backgroundColor: const Color(0xffF0F9EE),
      body: Stack(
        children: [
          // Background bawah
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
          // Header atas
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: Get.width,
              child: Image.asset(
                'assets/images/home/homepage_header.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form & Konten
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tombol kembali
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                        //Get.offAllNamed('/home');
                      },
                    ),
                    const SizedBox(height: 10),

                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'Ubah IP Server',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1A3C40),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: ipTextController,
                                  decoration: const InputDecoration(
                                    labelText: 'Alamat IP Server',
                                    border: OutlineInputBorder(),
                                    hintText:
                                        'contoh: http://192.168.1.100:3000',
                                  ),
                                  keyboardType: TextInputType.url,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final ipInput =
                                          ipTextController.text.trim();

                                      if (!ipInput.startsWith('http')) {
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
