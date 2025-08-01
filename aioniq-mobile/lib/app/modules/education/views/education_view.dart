import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff60AB4D),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800; // tablet / laptop

            return Column(
              children: [
                // ─── AppBar sederhana ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white, size: 22),
                            const SizedBox(width: 6),
                            const Text('Kembali',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ─── Konten Utama ──────────────────────────────────────────────
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Kolom Gambar (scroll-able jika banyak) ────────────
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isWide ? 260 : constraints.maxWidth * 0.33,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            children: _buildImages(),
                          ),
                        ),
                      ),

                      // ── Kolom Teks (scrollable) ──────────────────────────
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Obx(
                            () => SingleChildScrollView(
                              child: _buildPageContent(), // isi dinamis
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ───────────────────────────── Helpers ────────────────────────────────
  // Gambar navigasi samping
  List<Widget> _buildImages() {
    final items = ['temperature', 'humidity', 'water_quality', 'ph'];
    return List.generate(items.length, (i) {
      return Obx(
        () => GestureDetector(
          onTap: () => controller.activePage.value = i,
          child: _buildImage(i, items[i]),
        ),
      );
    });
  }

  Widget _buildImage(int index, String assetName) {
    final isActive = controller.activePage.value == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 140,
      child: Stack(
        children: [
          // highlight background
          if (isActive)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 230,
                decoration: const BoxDecoration(
                  color: Color(0xff60AB4D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
          Center(
            child: Image.asset(
              isActive
                  ? 'assets/images/education/${assetName}_white.png'
                  : 'assets/images/home_icons/$assetName.png',
              width: 90,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────── Styles ────────────────────────────────────
  final _boldStyle = const TextStyle(
      fontSize: 14, color: Color(0xffDFF8D5), fontWeight: FontWeight.bold);
  final _normalStyle = const TextStyle(fontSize: 12, color: Color(0xffDFF8D5));

  // ────────────────────────── Konten Dinamis ────────────────────────────
  Widget _buildPageContent() {
    final data = controller.aquaponicsData[controller.activePage.value];

    // halaman khusus indeks ke-2
    if (controller.activePage.value == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title,
              style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF6EDD9))),
          const SizedBox(height: 10),
          Text(data.optimalRange, style: _boldStyle),
          const SizedBox(height: 18),
          Text('Batas Aman', style: _boldStyle),
          ...data.impacts.map((e) => Text('- $e', style: _normalStyle)),
          const SizedBox(height: 18),
          Text('Saat melewati batas maksimal:', style: _boldStyle),
          ...data.actions.map((e) => Text('- $e', style: _normalStyle)),
          const SizedBox(height: 18),
          Text('Catatan Penting:', style: _boldStyle),
          Text(
            'Nilai batas optimal dan maksimal parameter air dan udara dapat '
            'bervariasi tergantung jenis tanaman dan ikan. Selalu pantau kondisi '
            'secara berkala dan konsultasikan dengan tim ahli.',
            style: _normalStyle,
          ),
        ],
      );
    }

    // halaman umum (indeks 0,1,3)
    final impacts = data.impacts;
    final actions = data.actions;
    final firstPart = actions.take(2).toList();
    final secondPart = actions.skip(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.title,
            style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xffF6EDD9))),
        const SizedBox(height: 10),
        Text(data.optimalRange, style: _boldStyle),
        const SizedBox(height: 18),
        Text('Batas Maksimal: ${data.maxLimit}', style: _boldStyle),
        const SizedBox(height: 6),
        Text('Batas Minimal: ${data.minLimit}', style: _boldStyle),
        const SizedBox(height: 18),
        Text('Dampak:', style: _boldStyle),
        ...impacts.map((e) => Text('- $e', style: _normalStyle)),
        const SizedBox(height: 18),
        Text('Saat melewati batas maksimal:', style: _boldStyle),
        ...firstPart.map((e) => Text('- $e', style: _normalStyle)),
        const SizedBox(height: 16),
        if (secondPart.isNotEmpty) ...[
          Text('Saat melewati batas minimal:', style: _boldStyle),
          ...secondPart.map((e) => Text('- $e', style: _normalStyle)),
        ],
      ],
    );
  }
}
