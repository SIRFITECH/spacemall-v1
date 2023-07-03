import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateFieldController extends GetxController {
  static DateFieldController get instance => Get.find();
  var expiryTapped = false.obs;
  var alertTapped = false.obs;
  var isTapped = false.obs;

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  // pickDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null) {
  //     selectedDate.value = pickedDate;
  //     print('Selected date: ${selectedDate.value}');
  //   }
  // }

  Future<DateTime> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    return pickedDate ?? DateTime.now();
  }

  void toggleDate() {
    isTapped.value = true;
    expiryTapped = false.obs;
    alertTapped = false.obs;
    update();
  }

  // void toggleExpiry() {
  //   expiryTapped.value = true;
  //   print(expiryTapped);
  //   alertTapped.value = false;
  //   print(alertTapped);
  //   update();
  //   print('toggleExpiry Toggled');
  // }

  // void toggleAlert() {
  //   alertTapped.value = true;
  //   expiryTapped.value = false;
  //   update();
  //   print(' toggleAlert Toggled');
  // }
}
