// import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';

import '../../../../../../repository/hive_boxes.dart';

class ReceiptsController extends GetxController {
  // The purpose of this class is to hold and manipulate the receipt state
  // its functions are:
  // 1. Hold receipt variables
  // 2. Deliver receipt variable manipulation
  // 3. Arrange receipt data for saving to the db
  // 4. act as the only public interface to receipt component

  static ReceiptsController get instance => Get.put(ReceiptsController());
  // final ReceiptsController receiptController = ReceiptsController();

  RxString cartTotal = '0'.obs;
  RxList<ReceiptsModel> receipts = <ReceiptsModel>[].obs;

  Rx<DateTime> today = Rx<DateTime>(DateTime.now());
  DateTime now = DateTime.now();

  RxString fromSelectedDate = ''.obs;
  RxString toSelectedDate = ''.obs;

  RxInt receiptNo = 0000001.obs;
  RxBool receiptStatus = false.obs;

  List<ReceiptsModel> convertReceipts(List receiptsFromDb) {
    List<ReceiptsModel> result = [];
    for (var item in receiptsFromDb) {
      ReceiptsModel.fromMap(item);
    }
    return result;
  }

  Rx<DateTime> selectedDateTime = DateTime.now().obs;

  DateTime lastWeekDate = DateTime.now().subtract(const Duration(days: 7));
  Rx<DateTime> fromDate =
      Rx<DateTime>(DateTime.now().subtract(const Duration(days: 7)));
  Rx<DateTime> toDate = Rx<DateTime>(DateTime.now());

  void showCalendarAndSetToDate(BuildContext context) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      DateTime selectedDate = await SalesController.instance.pickiOSDate(
        context,
        // screenSize
      );
      // ignore: unnecessary_null_comparison
      if (selectedDate != null) {
        // receiptController.
        fromSelectedDate.value = DateFormat('d MMM').format(selectedDate);
      } else {
        // receiptController.
        fromSelectedDate.value = DateFormat('d MMM').format(DateTime.now());
      }
    } else {
      DateTime selectedDate = await SalesController.instance.pickDate(context);
      // ignore: unnecessary_null_comparison
      if (selectedDate != null) {
        // receiptController.
        fromSelectedDate.value = DateFormat('d MMM').format(selectedDate);
      } else {
        // receiptController.
        fromSelectedDate.value = DateFormat('d MMM').format(DateTime.now());
      }
    }
  }

  // async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2022, 1, 1),
  //     lastDate: DateTime(2023, 12, 31),
  //   );

  //   if (pickedDate != null) {
  //     toDate.value = pickedDate;
  //   }
  // }

  // get stores
  List<ReceiptsModel> getStoresFromBox() {
    List<ReceiptsModel> receipts = [];
    for (var key in receiptsBox.keys) {
      if (key.startsWith('store-')) {
        ReceiptsModel? store = receiptsBox.get(key);
        if (store != null) {
          receipts.add(store);
        }
      }
    }
    return receipts;
  }
}
