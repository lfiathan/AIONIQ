import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/constant/themeData.dart';
import 'app/routes/app_pages.dart';
import 'package:aioniq/app/modules/ip_setting/controllers/ip_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  Get.put(IpController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      title: "Apens-iot",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
