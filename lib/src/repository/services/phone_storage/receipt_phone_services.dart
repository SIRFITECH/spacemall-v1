import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositories/local_db_inteface/receipt_local_db_adapter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../hive_boxes.dart';

class ReceiptPhoneService extends ReceiptLocalDataBaseAdapter {
  final AddItemRepo addItemRepo = Get.find();
  final ReceiptsController receiptsController = Get.find();

  void getReceiptsFromPhone() {}
  void deleteReceiptFromPhone() {}
  void editReceiptInPhone() {}

  @override
  Future<void> saveReceiptToDevice(ReceiptsModel newReceipt) async {
    try {
      StoreModel store = storeBox.get(
        AddItemRepo.instance.currentStore.value,
        defaultValue: StoreModel(
          logoLocalPath: '',
          logoRemotePath: '',
          storeName: '',
          bankName: '',
          accountNumber: '',
          contact: '',
          stock: RxList([]),
          receipts: [],
          debts: [],
          staff: [],
          sales: [],
          customer: [],
          storeId: '',
          categories: [],
        ),
      );

      // Add the new receipt item to the store's receipts list
      store.receipts.add(newReceipt);

      // update the storeBox
      await storeBox.put(
        addItemRepo.currentStore.value,
        store,
      );

      receiptsController.receipts.add(newReceipt);
      spaceMallSnackBar(
        'Receipt created',
        'Receipt added successfully',
        kBlack,
        kWhiteLight,
      );
    } catch (e) {
      debugPrint(
          'Error ${e.toString()} occured in saveReceiptToDevice() inside ReceiptPhoneService while adding receipt');
      spaceMallSnackBar(
        'Error Adding receipt to phone',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
