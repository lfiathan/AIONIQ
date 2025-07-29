import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/faq_model.dart';

class FaqController extends GetxController {
  RxBool customTileExpanded = false.obs;

  List<FaqModel> faqs = [
    FaqModel(
        question: 'Apa itu Akuaponik?',
        answer:
            'Akuaponik adalah teknologi pertanian yang menggabungkan akuakultur (budidaya ikan) dan hidroponik (budidaya tanaman tanpa tanah) dalam satu ekosistem. Limbah ikan menyediakan nutrisi bagi tanaman, sementara tanaman membantu membersihkan air, menciptakan lingkungan yang berkelanjutan dan efisien. Sistem ini menghemat air hingga 90%, meminimalkan kebutuhan lahan, dan mengurangi penggunaan pupuk kimia, menjadikannya solusi ideal untuk pertanian perkotaan dan daerah dengan sumber daya terbatas.'),
    FaqModel(
        question: 'Bagaimana cara Apens-iot memonitor pH air secara otomatis?',
        answer:
            'Apens-iot menggunakan sensor pH-4502c yang memantau pH air secara kontinu. Data real-time ini dikirim ke aplikasi mobile Anda, memungkinkan monitoring dan penyesuaian pH sesuai kebutuhan.'),
    FaqModel(
        question: 'Apa yang harus saya lakukan jika suhu air terlalu tinggi?',
        answer:
            'Jika suhu air melebihi batas normal, Anda bisa mengaktifkan sistem pendinginan melalui fitur kontrol otomatis di Apens-iot. Anda juga dapat mengatur notifikasi untuk menerima alert saat suhu mencapai titik kritis.'),
    FaqModel(
        question: 'Bagaimana Apens-iot membantu dalam pengelolaan pakan ikan?',
        answer:
            'Apens-iot memiliki fitur pemberian pakan otomatis yang dapat dijadwalkan melalui aplikasi. Anda bisa mengatur waktu dan jumlah pakan harian, dan Apens-iot akan memastikan ikan diberi makan tepat waktu dan sesuai jumlah.'),
    FaqModel(
        question:
            'Dapatkah Apens-iot digunakan dalam skala besar untuk pertanian komersial?',
        answer:
            'Ya, Apens-iot fleksibel dan dapat diskalakan untuk skala kecil maupun besar. Anda bisa menghubungkan beberapa unit Apens-iot dalam satu jaringan untuk memantau dan mengelola lebih banyak tangki atau bedengan tanaman dalam operasi komersial.'),
    FaqModel(
        question: 'Bagaimana cara melakukan pemeliharaan rutin pada Apens-iot?',
        answer:
            'Pastikan sensor dan unit Apens-iot bebas dari debu dan kotoran, periksa koneksi kabel, dan pastikan software selalu diperbarui. Kami menyediakan manual teknis dan panduan online yang dapat diakses melalui aplikasi untuk membantu pemeliharaan dan perbaikan sederhana.'),
  ];

  RxList<FaqModel> filteredFaqs = <FaqModel>[].obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredFaqs.value = faqs;

    searchController.addListener(() {
      filterFaqs(searchController.text);
      print(searchController.text);
      print(filteredFaqs);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void filterFaqs(String query) {
    if (query.isEmpty) {
      filteredFaqs.value = faqs;
    } else {
      filteredFaqs.value = faqs
          .where(
              (faq) => faq.question.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
