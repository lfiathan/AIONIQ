import 'package:aioniq/app/data/models/education_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  final PageController pageController = PageController();

  RxInt activePage = 0.obs;

  List<AquaponicsInfo> aquaponicsData = [
    AquaponicsInfo(
      title: "Temperatur",
      optimalRange: "22°C - 28°C",
      maxLimit: ">30°C",
      minLimit: "<18°C",
      impacts: [
        "Pertumbuhan tanaman terhambat",
        "Metabolisme ikan terganggu",
        "Risiko penyakit pada ikan meningkat",
        "Ikan menjadi lebih lamban",
      ],
      actions: [
        "Nyalakan sprayer untuk mendinginkan air dan ruangan",
        "Lakukan aerasi air untuk meningkatkan kadar oksigen",
        "Nyalakan heater untuk menghangatkan air",
        "Kurangi aliran air pada sistem akuaponik",
      ],
    ),
    AquaponicsInfo(
      title: "Kelembapan",
      optimalRange: "50% - 70%",
      maxLimit: ">80%",
      minLimit: "<40%",
      impacts: [
        "Pertumbuhan jamur pada tanaman meningkat",
        "Ikan mengalami stres",
        "Transpirasi tanaman terhambat",
        "Kulit ikan kering dan mudah iritasi",
      ],
      actions: [
        "Nyalakan kipas angin untuk meningkatkan sirkulasi udara",
        "Kurangi aliran air pada sistem akuaponik",
        "Gunakan humidifier untuk meningkatkan kelembapan udara",
        "Tutup sistem akuaponik dengan plastik",
      ],
    ),
    AquaponicsInfo(
      title: "Kualitas Air",
      optimalRange: "Nitrat (NO3), Fosfat (PO4), Amonia (NH3), Nitrit (NO2)",
      maxLimit: "",
      minLimit: "",
      impacts: [
        "Nitrat (NO3): <50 ppm",
        "Fosfat (PO4): <1 ppm",
        "Amonia (NH3): <0.1 ppm",
        "Nitrit (NO2): <0.1 ppm",
      ],
      actions: [
        "Lakukan pergantian air sebagian",
        "Bersihkan sistem akuaponik secara berkala",
        "Gunakan filter air yang tepat",
        "Lakukan penambahan probiotik",
      ],
    ),
    AquaponicsInfo(
      title: "pH Air",
      optimalRange: "6.5 - 7.5",
      maxLimit: ">8.0",
      minLimit: "<6.0",
      impacts: [
        "Penyerapan nutrisi terhambat pada tanaman",
        "Ikan mengalami stres",
        "Risiko keracunan amonia pada ikan meningkat",
        "Pertumbuhan tanaman terhambat",
        "Ikan mudah terserang penyakit",
      ],
      actions: [
        "Tambahkan bahan penurun pH seperti asam asetat atau cuka",
        "Lakukan pergantian air sebagian",
        "Tambahkan bahan penambah pH seperti soda kue atau kapur",
        "Lakukan pergantian air sebagian",
      ],
    ),
  ];
}
