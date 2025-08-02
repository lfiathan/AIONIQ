import 'package:akuabot/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BuildSchedulesWidget extends GetView<HomeController> {
  const BuildSchedulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //margin: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      height: Get.height * 0.22,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.05),
            blurRadius: 12.5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        if (controller.schedulesController.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemCount: controller.schedulesController.length,
          itemBuilder: (context, index) {
            final schedule = controller.schedulesController[index];
            DateTime scheduleTime = DateTime.parse(schedule['schedule']);
            int duration = schedule['duration'] ?? 0;
            bool isActive = schedule['isActive'] ?? false;

            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM y', 'id_ID')
                          .format(scheduleTime),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('HH:mm').format(scheduleTime),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '($duration detik)',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    DatePickerBdaya.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2024, 1, 1),
                      maxTime: DateTime(2027, 12, 31),
                      onConfirm: (date) {
                        controller.updateScheduleTime(index, date);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.id,
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xff60AB4D),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return DurationPickerBottomSheet(scheduleIndex: index);
                      },
                    );
                  },
                  child: const Icon(
                    Icons.timelapse,
                    color: Color(0xff60AB4D),
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: isActive,
                  onChanged: (value) {
                    controller.updateScheduleActiveStatus(index, value);
                  },
                  activeColor: const Color(0xff60AB4D),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class DurationPickerBottomSheet extends StatelessWidget {
  final int scheduleIndex;
  const DurationPickerBottomSheet({required this.scheduleIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

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
                                backgroundColor: Colors.green,
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
                          : const Color(0xff60AB4D),
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

