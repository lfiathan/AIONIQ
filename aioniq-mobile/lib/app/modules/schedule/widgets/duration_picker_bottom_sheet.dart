import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import '../controllers/schedule_controller.dart';

class DurationPickerBottomSheet extends StatelessWidget {
  final int scheduleIndex;
  const DurationPickerBottomSheet({required this.scheduleIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleController controller = Get.find();

    return Container(
      height: Get.height * 0.35,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Text('Batal',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Obx(() {
                return GestureDetector(
                  onTap: controller.isButtonDisabled.value
                      ? null
                      : () {
                          controller.isButtonDisabled.value = true;
                          controller
                              .updateScheduleDuration(
                                  scheduleIndex, controller.feedDuration.value)
                              .then((success) {
                            if (success) {
                              controller.feedDuration.value = 0;
                              Get.back();
                              Get.snackbar(
                                "Berhasil",
                                "Durasi berhasil diubah",
                                backgroundColor: AppColors.lightBlue,
                                colorText: Colors.white,
                                isDismissible: true,
                                forwardAnimationCurve: Curves.ease,
                                duration: const Duration(seconds: 1),
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Gagal mengubah durasi",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          }).whenComplete(() {
                            controller.isButtonDisabled.value = false;
                          });
                        },
                  child: Text(
                    "Pilih",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: controller.isButtonDisabled.value
                          ? Colors.grey
                          : AppColors.normalBlueActive,
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Durasi Pemberian Pakan (Detik)"),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              onSelectedItemChanged: (int index) {
                controller.feedDuration.value = index;
              },
              children: List<Widget>.generate(
                  60, (index) => Center(child: Text('$index'))),
            ),
          ),
        ],
      ),
    );
  }
}
