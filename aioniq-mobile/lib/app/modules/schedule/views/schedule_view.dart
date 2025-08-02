import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import '../controllers/schedule_controller.dart';
import '../widgets/duration_picker_bottom_sheet.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            Center(
              child: Text(
                'Jadwal Pakan',
                style:
                    Get.textTheme.headlineMedium!.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Obx(() {
                  if (controller.schedulesController.isEmpty) {
                    return const Center(child: Text('Belum ada jadwal.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    itemCount: controller.schedulesController.length,
                    itemBuilder: (context, index) {
                      final schedule = controller.schedulesController[index];
                      final scheduleDate =
                          DateTime.tryParse(schedule['schedule']) ??
                              DateTime.now();
                      final isActive = schedule['isActive'] ?? false;
                      final duration = schedule['duration'] ?? 0;
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                              color: AppColors.normalBlue, width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('EEEE, d MMMM y', 'id_ID')
                                        .format(scheduleDate),
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: Get.height * 0.005),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBlue,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          DateFormat('HH:mm', 'id_ID')
                                              .format(scheduleDate),
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBlue,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '$duration detik',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      DatePickerBdaya.showDateTimePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime(2024, 1, 1),
                                        maxTime: DateTime(2027, 12, 31),
                                        onChanged: (date) {},
                                        onConfirm: (date) async {
                                          final id = schedule['id'];
                                          if (id != null) {
                                            // Memanggil metode updateScheduleTime dari controller
                                            final response = await controller
                                                .updateScheduleTime(
                                                    index, date);
                                            if (response) {
                                              Get.snackbar("Berhasil",
                                                  "Jadwal berhasil diubah",
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white);
                                            } else {
                                              Get.snackbar("Gagal",
                                                  "Gagal mengubah jadwal",
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          }
                                        },
                                        currentTime: scheduleDate,
                                        locale: LocaleType.id,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: AppColors.darkBlueHover,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return DurationPickerBottomSheet(
                                              scheduleIndex: index);
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.timelapse,
                                      color: AppColors.darkBlueHover,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.01),
                                  Switch(
                                    value: isActive,
                                    onChanged: (value) async {
                                      // Memanggil metode updateScheduleActiveStatus dari controller
                                      final id = schedule['id'];
                                      if (id != null) {
                                        await controller
                                            .updateScheduleActiveStatus(
                                                index, value);
                                      }
                                    },
                                    activeColor: AppColors.normalBlueActive,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
