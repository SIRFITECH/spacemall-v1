import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';

import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/date_widget_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

class AddItemRepo extends GetxController {
  static AddItemRepo get instance => Get.find();

  static AddItemController addItemController = Get.find();
  static AddCategoryController addCategoryController = Get.find();
  static DateFieldController dateFieldController = Get.find();

  final itemPic = addItemController.itemPic.value;

  RxString currentStore = ''.obs;

  ///PHONE OPERATIONS

  Future saveItemData() async {
    // fetch store from storeBox
    StoreModel storeList = storeBox.get(
      currentStore.value,
      defaultValue: StoreModel(
        logo: null,
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
      itemCount: RxInt(0),
      itemId: const Uuid().v4(),
      morePics: addItemController.moreImages,
    );
    addCategoryController.categoryValue.value?.itemsInCategory++;
    addCategoryController.categoryValue.value?.items.add(newItem);

    // Add the new stock item to the store's stock list
    storeList.stock.add(newItem);

// update the storeBox
    await storeBox.put(
      currentStore.value,
      storeList,
    );

    Get.back();
    addItemController.isItemAdded.value = true;
    AddItemController.instance.clearImages();
  }
  // edit an itemin the stock list

  Future editItemData(AddItemModel editedItem) async {
    StoreModel storeList = storeBox.get(
      currentStore.value,
      defaultValue: StoreModel(
        logo: null,
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
        storeList.stock.indexWhere((item) => item.itemId == editedItem.itemId);
    storeList.stock[itemIndex] = editedItem;
    await storeBox.put(
      currentStore.value,
      storeList,
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

  ///DATABASE OPERATIONS
}
