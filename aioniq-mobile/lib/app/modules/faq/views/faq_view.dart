import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aioniq/app/constant/app_colors.dart';
import 'package:aioniq/app/routes/app_pages.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'FAQs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.SETTING),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05),

            // Search Bar
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: Get.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.lightBlue, width: 1.5),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: 'Search FAQ',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.search, color: AppColors.normalBlue),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: AppColors.normalBlue),
                  suffixIcon: const SizedBox(width: 40),
                ),
              ),
            ),

            // FAQ List
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Obx(() {
                  if (controller.filteredFaqs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No FAQ found',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                      itemCount: controller.filteredFaqs.length,
                      itemBuilder: (context, index) {
                        final faq = controller.filteredFaqs[index];
                        return Card(
                          surfaceTintColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ExpansionTile(
                            trailing: controller.customTileExpanded.value
                                ? const Icon(Icons.keyboard_arrow_up_rounded,
                                    color: AppColors.normalBlue)
                                : const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.normalBlue),
                            title: Text(
                              faq.question,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            leading: const Icon(
                              Icons.help_rounded,
                              color: AppColors.normalBlue,
                            ),
                            onExpansionChanged: (value) {
                              controller.customTileExpanded.value = value;
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    const Divider(
                                        color: Colors.black, height: 1),
                                    const SizedBox(height: 10),
                                    Text(
                                      faq.answer,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
