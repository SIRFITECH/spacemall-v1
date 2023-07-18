import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';

class DebtController extends GetxController {
  static DebtController get instance => Get.put(
        DebtController(),
      );

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  List<DebtsModel> convertDebts(List debtFromDb) {
    List<DebtsModel> result = [];
    for (var item in debtFromDb) {
      DebtsModel.fromMap(item);
    }
    return result;
  }
}
