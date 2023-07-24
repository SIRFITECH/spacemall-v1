import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

class SalesController extends GetxController {
  static SalesController get instance => Get.find();

  DateTime now = DateTime.now();
  RxString date = ''.obs;

  DateTime yesterday = DateTime.now().subtract(const Duration(days: 7));

  Future<DateTime> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    return pickedDate ?? DateTime.now();
  }

  Future<String> pickYesterday(BuildContext context) async {
    DateTime pickedDate = now;

    return date.value = DateFormat('d MMM').format(
      pickedDate.subtract(const Duration(days: 1)),
    );
  }

  Future<String> pickTommorow(BuildContext context) async {
    DateTime pickedDate = now;

    return date.value = DateFormat('d MMM').format(
      pickedDate.add(const Duration(days: 1)),
    );
  }

  List<SalesModel> convertSales(List salesFromDb) {
    List<SalesModel> result = [];
    for (var item in salesFromDb) {
      SalesModel.fromMap(item);
    }
    return result;
  }
}
