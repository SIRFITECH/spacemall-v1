import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';

import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/date_widget_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../repository/services/network_connectivity/stock_firebase_services.dart';
import '../../../../../../../repository/services/phone_storage/stock_phone_services.dart';

class AddItemRepo extends GetxController {
  static AddItemRepo get instance => Get.find();

  static AddItemController addItemController = Get.find();
  static AddCategoryController addCategoryController = Get.find();

  static DateFieldController dateFieldController = Get.find();

  final itemPic = addItemController.itemPic.value;

  RxString currentStore = ''.obs;
  var stockList = <AddItemModel>[].obs;

  void setStockList() {
    stockList.value = storeBox.get(
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
      ).stock,
    );
  }

  ///PHONE OPERATIONS

  Future saveItemData() async {
    // we just have few things to achieve here
    // 1. save the item to server
    // 2. save the item to device
    // 3. return error if there is error and success if there is success

    // create a new item
    AddItemModel newItem = AddItemModel(
      itemPic: addItemController.itemPic.value,
      itemName: addItemController.itemName.text.trim(),
      itemSellingPrice: addItemController.sellingPrice.text.trim(),
      itemCategory: addCategoryController.categoryValue.value?.categoryName,
      itemQuantity: addItemController.stockAvailable.text.trim(),
      itemCostPrice: addItemController.costPrice.text.trim(),
      trackProfit: addItemController.trackProfit.value,
      trackLowStock: addItemController.trackLowStock.value,
      preventItemSalesWhenOutOfStock:
          addItemController.preventItemSalesWhenOutOfStock.value,
      trackExpiry: addItemController.trackExpiry.text.trim(),
      expiryAlert: addItemController.expiryAlert.text.trim(),
      itemCount: 0,
      itemId: const Uuid().v4(),
      morePics: addItemController.moreImages,
    );

    try {
      StockFirebaseServices().saveStockItemToDB(
        stockItem: newItem,
        onSucess: () {
          StockPhoneServices().saveStockItemToDevice(newItem);
          print('Add item to firebase successful!!');
        },
      );
    } catch (e) {
      debugPrint(
          'An error occured in saveItemData() in addItemRepo: ${e.toString()}');
      spaceMallSnackBar(
        'Error adding item',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  // edit an itemin the stock list

  Future editItemData(AddItemModel editedItem) async {
    StoreModel store = storeBox.get(
      currentStore.value,
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
    await storeBox.put(
      currentStore.value,
      store,
    );

    Get.snackbar(
      'Edited',
      '${editedItem.itemName} edited',
      backgroundColor: Colors.green,
      colorText: kWhiteLight,
    );

    Get.back();
  }

  // clear the TextEditingControllers
  clearControllers() {
    addItemController.itemName.clear();
    addItemController.sellingPrice.clear();
    addItemController.stockAvailable.clear();
    addItemController.costPrice.clear();
    addItemController.trackExpiry.clear();
    addItemController.expiryAlert.clear();
    addItemController.itemPic.value = null;
    addCategoryController.categoryValue.value = null;
    addItemController.trackProfit.value = false;
    addItemController.trackLowStock.value = false;
    addItemController.preventItemSalesWhenOutOfStock.value = false;
    dateFieldController.expiryTapped.value = false;
    dateFieldController.alertTapped.value = false;
    dateFieldController.isTapped.value = false;
  }

// fetch saved data from phone storage
  Future<List<AddItemModel>> getDataFromPhone() async {
    List<AddItemModel> itemList =
        await stockBox.get('item_list', defaultValue: null);
    return itemList;
  }

  Future<void> deleteLastItemFromPhone() async {
    if (stockBox.isNotEmpty) {
      stockBox.deleteAt(stockBox.length - 1);
      update();
    }
  }

  // add item to hive

  Future<void> addToHive(AddItemModel item) async {
    AddItemController.instance.itemList.add(item);
    await stockBox.put('item-${addItemController.itemName.text.trim()}', item);

    update();
  }
}
