import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportsController extends GetxController {
  static ReportsController get instance => Get.put(ReportsController());

  Rx<DateTime> today = Rx<DateTime>(DateTime.now());
  DateTime now = DateTime.now();

  RxString todayReport = ''.obs;
  RxBool showPOSGrid = true.obs;
  RxBool showLowToHigh = true.obs;

  Future<String> pickYesterday(BuildContext context) async {
    now = now.subtract(const Duration(days: 1));
    DateTime pickedDate = now;

    return todayReport.value = DateFormat('d MMM').format(
      pickedDate.subtract(const Duration(days: 1)),
    );
  }

  Future<String> pickTommorow(BuildContext context) async {
    now = now.add(const Duration(days: 1));

    DateTime pickedDate = now;

    return todayReport.value = DateFormat('d MMM').format(
      pickedDate.add(const Duration(days: 1)),
    );
  }

  void setStoreFrontGrid() {
    showPOSGrid.value = false;
    update();
  }

  void setPOSGrid() {
    showPOSGrid.value = true;
    update();
  }

  List posReport = [
    {
      // finance summary - sales report
      "title": "TOTAL SALE",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "PROFITS",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      // finance summary - category
      "title": "TOP STOCK",
      "detail": "TOP STOCK: 25",
      "value": "",
    },
    {
      "title": "TOP CARTEGORY",
      "detail": "DRINKS: 55",
      "value": "",
    },
    {
      "title": "SALES",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "TAX",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "DISCOUNT",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "AVERAGE\n SALES VALUE",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "TOP CUSTOMER",
      "detail": "OSAGIE\n DAVID",
      "value": "osagiedav@gmail.com",
    },
    {
      "title": "PAYMENT MODES",
      "detail": "CASH",
      "value": "N 100,000.00",
    },
    {
      "title": "SOLD BY",
      "detail": "OSAGIE\n DAVID",
      "value": "osagiedav@gmail.com"
    },
  ];

  List storeFrontReport = [
    {
      "title": "TOTAL SALE",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "PROFITS",
      "detail": "N 150,000.00",
      "value": "",
    },
    {
      "title": "TOP STOCK",
      "detail": "TOP STOCK: 60",
      "value": "",
    },
    {
      "title": "TOP CARTEGORY",
      "detail": "DRINKS: 55",
      "value": "",
    },
    {
      "title": "SALES",
      "detail": "N 150,000.00",
      "value": "",
    },
    {
      "title": "TAX",
      "detail": "N 20,000.00",
      "value": "",
    },
    {
      "title": "DISCOUNT",
      "detail": "N 00.00",
      "value": "",
    },
    {
      "title": "AVERAGE \n SALES VALUE",
      "detail": "N 100,000.00",
      "value": "",
    },
    {
      "title": "TOP CUSTOMER",
      "detail": "OSAGIE\n DAVID",
      "value": "osagiedav@gmail.com",
    },
    {
      "title": "PAYMENT MODES",
      "detail": "CASH",
      "value": "N 100,000.00",
    },
    {
      "title": "SOLD BY",
      "detail": "OLUWAFEMI\n ADEYEMI",
      "value": "femiade@gmail.com"
    },
  ];
}
