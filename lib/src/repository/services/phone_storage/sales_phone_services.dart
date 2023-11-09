import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:spacemall/data/repositoies/local_db_inteface/sales_local_db_adapter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../hive_boxes.dart';

class SalesPhoneService extends SalesLocalDataBaseAdapter {
  @override
  Future<void> saveSalesToDevice(SalesModel newSales) async {
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

      // String paymentMood = payment;
      // // Add the new category to the store's categories list
      store.sales.add(newSales);

      // Update the storeBox with the modified sale
      await storeBox.put(AddItemRepo.instance.currentStore.value, store);
    } catch (e) {
      debugPrint(
          'Error from the saveSalesToDevice() in SalesPhoneService: ${e.toString()}');
      spaceMallSnackBar(
        'Error add sales to phone',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
