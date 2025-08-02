import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:akuabot/app/constant/app_colors.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

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
                  // Observing schedulesController RxList
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

                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.normalBlue),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Tanggal & Waktu
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    DateFormat('HH:mm', 'id_ID')
                                        .format(scheduleDate),
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            // Edit & Switch aktif/nonaktif
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
                                        // Panggil API update jadwal
                                        final id = schedule['id'];
                                        if (id != null) {
                                          try {
                                            // Panggil API update jadwal dengan PATCH/PUT sesuai controller
                                            final response =
                                                await controller.updateSchedule(
                                                    id, date.toIso8601String());
                                            if (response) {
                                              Get.snackbar("Berhasil",
                                                  "Jadwal berhasil diubah",
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white);
                                              controller
                                                  .fetchSchedules(); // Refresh data
                                            } else {
                                              Get.snackbar("Gagal",
                                                  "Gagal mengubah jadwal",
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          } catch (e) {
                                            Get.snackbar("Error",
                                                "Terjadi kesalahan: $e");
                                          }
                                        }
                                      },
                                      currentTime: scheduleDate,
                                      locale: LocaleType.id,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.normalBlue,
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.05),
                                Switch(
                                  value: isActive,
                                  onChanged: (value) async {
                                    final id = schedule['id'];
                                    if (id != null) {
                                      await controller.changeIsActive(
                                          id, value);
                                    }
                                  },
                                  activeColor: AppColors.normalBlueActive,
                                ),
                              ],
                            )
                          ],
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
