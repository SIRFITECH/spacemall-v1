import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacemall/data/repositories/local_db_inteface/stock_local_db_adapter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../hive_boxes.dart';

class StockPhoneServices extends StockLocalDataBaseAdapter {
  final AddItemRepo addItemRepo = AddItemRepo();

  // static AddCategoryController addCategoryController = Get.find();
  final AddCategoryController addCategoryController = AddCategoryController();
  final AddItemController addItemController = AddItemController();

  // fetch store from storeBox
  final StoreModel _storeList = storeBox.get(
    AddItemRepo.instance.currentStore.value,
    defaultValue: StoreModel(
      logoLocalPath: '',
      logoRemotePath: '',
      storeName: '',
      bankName: '',
      accountNumber: '',
      contact: '',
      stock: [],
      receipts: [],
      debts: [],
      staff: [],
      sales: [],
      customer: [],
      storeId: '',
      categories: [],
    ),
  );

  void getStocksFromDevice() {}

  @override
  Future<void> saveStockItemToDevice(AddItemModel stockItem) async {
    stockBox = await Hive.openBox<AddItemModel>(
        AddItemRepo.instance.currentStore.value); // typeId: 10
    try {
      // var category = addCategoryController.categoryValue.value;
      // increament the category count and Add the new stock item to the store's category list
      addCategoryController.categoryValue.value?.itemsInCategory++;

      addCategoryController.categoryValue.value?.items.add(stockItem);

      // Add the new stock item to the store's stock list
      _storeList.stock.add(stockItem);

      // update the storeBox
      await storeBox.put(
        AddItemRepo.instance.currentStore.value,
        _storeList,
      );

      Get.back();
      addItemController.isItemAdded.value = true;
      AddItemController.instance.clearImages();
    } catch (e) {
      debugPrint(
          'error from saveStockItemToDevice() in StockPhoneServices add stockItem to device: ${e.toString()}');
      spaceMallSnackBar(
        'Error add Item to device',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  @override
  Future<void> editStockInDevice(AddItemModel editedItem) async {
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

      int itemIndex =
          store.stock.indexWhere((item) => item.itemId == editedItem.itemId);

      store.stock[itemIndex] = editedItem;

      await storeBox
          .put(
        addItemRepo.currentStore.value,
        store,
      )
          .then((value) {
        spaceMallSnackBar(
          'Edited',
          '${editedItem.itemName} edited',
          kWhiteLight,
          kGreenColor,
        );
      });
    } catch (e) {
      debugPrint('error editing stock: ${e.toString()}');
      spaceMallSnackBar('Error Editing', e.toString(), kWhiteLight, kRedColor);
    }
  }

  @override
  Future<void> deleteStockFromDevice(AddItemModel deleteItem) async {
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

      int itemIndex =
          store.stock.indexWhere((item) => item.itemId == deleteItem.itemId);

      // store.stock[itemIndex] = deleteItem;
      if (itemIndex != -1) {
        await storeBox.deleteAt(itemIndex
            // addItemRepo.currentStore.value,
            // store,
            );
        spaceMallSnackBar(
          'Edited',
          '${deleteItem.itemName} edited',
          Colors.green,
          kWhiteLight,
        );

        Get.back();
      } else {
        debugPrint('Error deleting item from phone');
        spaceMallSnackBar('Error Deleteing Item',
            'Error deleting item from phone', kWhiteLight, kRedColor);
      }
    } catch (e) {
      debugPrint('error editing stock: ${e.toString()}');
      spaceMallSnackBar(
          'Error Deleteing Item', e.toString(), kWhiteLight, kRedColor);
    }
  }
}
