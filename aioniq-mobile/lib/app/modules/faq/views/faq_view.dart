import 'package:akuabot/app/modules/faq/controllers/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
          ),
          // Header background atas
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: Get.width,
              child: Image.asset(
                'assets/images/home/homepage_header.png',
              ),
            ),
          ),
          // Konten FAQ
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Bar
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
                      'FAQs',
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

              // Search Bar
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff60AB4D).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: controller.searchController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Search FAQ',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20), // Adjust this
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.white),
                    suffixIcon: const SizedBox(width: 40),
                  ),
                ),
              ),

              // Konten FAQ
              Expanded(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.04,
                        vertical: Get.height * 0.01,
                      ),
                      itemCount: controller.filteredFaqs.length,
                      itemBuilder: (context, index) {
                        final faq = controller.filteredFaqs[index];
                        return Obx(() => Card(
                              surfaceTintColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: ExpansionTile(
                                trailing: controller.customTileExpanded.value
                                    ? const Icon(
                                        Icons.keyboard_arrow_up_rounded)
                                    : const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                title: Text(
                                  faq.question,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.help_rounded,
                                  color: Color(0xff60AB4D),
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
                                          color: Colors.black,
                                          height: 1,
                                        ),
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
                            ));
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
