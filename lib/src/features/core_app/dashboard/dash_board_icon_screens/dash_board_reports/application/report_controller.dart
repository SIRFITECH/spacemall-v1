import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  static ReportsController get instance => Get.put(ReportsController());

  Rx<DateTime> today = Rx<DateTime>(DateTime.now());

  void showCalendarAndSetToday(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    );

    if (pickedDate != null) {
      today.value = pickedDate;
    }
  }
}
