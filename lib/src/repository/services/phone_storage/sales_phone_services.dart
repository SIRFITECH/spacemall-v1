import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:spacemall/data/repositories/local_db_inteface/sales_local_db_adapter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_item_model.dart';
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

  List<SalesItemModel> convertCartToSalesItems(List<dynamic> cartData) {
    List<SalesItemModel> salesItems = [];
    for (var cartItem in cartData) {
      salesItems.add(SalesItemModel.fromMap(cartItem));
    }
    return salesItems;
  }

   getSalesFromDevice(String saleId) async {
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
      var salesList = [];
      for (var sale in store.sales) {
        salesList.add(sale.toMap());
      }

      List<Map<String, dynamic>> mappedSales =
          salesList.cast<Map<String, dynamic>>();

      for (var sales in mappedSales) {
        if (sales['saleId'] == saleId) {
          List cartItems = [];
          for (var cart in sales['cart']) {
            cartItems.add(cart);
            // print(cart);
          }

          return cartItems;
        }
      }

      // for (var sales in mappedSales) {
      //   if (sales['saleId'] == saleId) {
      //     List<SalesItemModel> cartItems =
      //         convertCartToSalesItems(sales['cart']);
      //     for (var cartItem in cartItems) {
      //       print(cartItem);
      //     }

      //     return cartItems;
      //   }
      // }
      // '4b04703c-2667-47a5-93a1-d8e624e7df82'
      // 7414ccff-1397-422e-afa7-321354c2bdca
      // print(salesList[12]);
    } catch (e) {
      debugPrint(
          'Error from the getSalesFromDevice() in SalesPhoneService: ${e.toString()}');
      spaceMallSnackBar(
        'Error fetching sales from phone',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
