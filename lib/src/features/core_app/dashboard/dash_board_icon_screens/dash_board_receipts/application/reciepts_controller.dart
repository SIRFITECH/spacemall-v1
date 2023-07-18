import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';

import '../../../../../../repository/hive_boxes.dart';

class ReceiptsController extends GetxController {
  static ReceiptsController get instance => Get.put(ReceiptsController());

  RxString cartTotal = '0'.obs;
  RxList<ReceiptsModel> receipts = <ReceiptsModel>[].obs;

  void addReceipt(ReceiptsModel newReceipt) {
    receipts.add(newReceipt);
  }

  RxInt receiptNo = 0.obs;
  RxBool receiptStatus = false.obs; // false = unsuccessful, true = successful

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
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    );

    if (pickedDate != null) {
      toDate.value = pickedDate;
    }
  }

  void showCalendarAndSetFromDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    );

    if (pickedDate != null) {
      fromDate.value = pickedDate;
    }
  }

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
