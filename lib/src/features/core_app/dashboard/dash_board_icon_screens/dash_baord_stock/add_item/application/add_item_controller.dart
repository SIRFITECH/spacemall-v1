import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class AddItemController extends GetxController {
  static AddItemController get instance => Get.put(
        AddItemController(),
      );
  static AddItemRepo addItemRepo = Get.put(
    AddItemRepo(),
  );

// observable variables
  RxString categoryValue = 'Category'.obs;
  var selectedIndex = 0.obs;

  RxBool isPressed = false.obs;
  RxInt numSelectedItems = 2.obs;

  // my initial variable
  RxList<AddItemModel> itemList = <AddItemModel>[].obs;

  void increaementSelectedItem(int tapedIndex) {
    if (tapedIndex >= 0) {
      numSelectedItems++;
    }
  }

  void decreaementSelectedItem(int tapedIndex) {
    if (tapedIndex >= 0) {
      selectedIndex--;
    }
  }

  void setCategory(newValue) => categoryValue.value = newValue;

  final categoryItems = <String>[
    'Category',
    'Drinks',
    'Protein',
    'Snacks',
    'Electronics',
  ];

  final moreImages = <String>[
    "Image 1",
    "Image 2",
    "Image 3",
    "Image 4",
  ];

// add item to hive

  Future<void> addToHive(AddItemModel item) async {
    AddItemController.instance.itemList.add(item);
    await stockItemBox.put('item-${itemName.text}', item);

    update();
  }

  printItemList() {
    print(itemList.length);
  }

  Rx<File?> itemPic = Rx(null);

  // final String category = '';
  final RxBool trackProfit = false.obs;
  final RxBool trackLowStock = false.obs;
  final RxBool preventItemSalesWhenOutOfStock = false.obs;
  final TextEditingController itemName = TextEditingController();
  final TextEditingController costPrice = TextEditingController();
  final TextEditingController sellingPrice = TextEditingController();
  final TextEditingController stockAvailable = TextEditingController();
  final TextEditingController trackExpiry = TextEditingController();
  final TextEditingController expiryAlert = TextEditingController();

  void setProfitTracking() {
    trackProfit.value = !trackProfit.value;
    print('track profit is ${trackProfit.value}');
    update();
  }

  void setLowStockTracking() {
    trackLowStock.value = !trackLowStock.value;
    print('Track low stock is ${trackLowStock.value}');
    update();
  }

  void setPreventItemSalesWhenOutOfStockTracking() {
    preventItemSalesWhenOutOfStock.value =
        !preventItemSalesWhenOutOfStock.value;
    print(
        'prevent item sale on low stock is ${preventItemSalesWhenOutOfStock.value}');
    update();
  }

  void selectItemImage(BuildContext context) async {
    itemPic = (await pickImage(context));
    update();
  }

  getItemPic() {}

  addItemToPhone() {
    addItemRepo.saveItemData();

    print('itemPic is: ${AddItemController.instance.itemPic.value}');
    print('category is: ${AddItemController.instance.categoryValue}');
    print('Track profit is: ${AddItemController.instance.trackProfit}');
    print('Track Low Stock is: ${AddItemController.instance.trackLowStock}');
    print(
        'Prevent sale is:${AddItemController.instance.preventItemSalesWhenOutOfStock}');
    print('item name is: ${AddItemController.instance.itemName.text.trim()}');
    print('cost price is: ${AddItemController.instance.costPrice.text.trim()}');
    print(
        'selling price is: ${AddItemController.instance.sellingPrice.text.trim()}');
    print(
        'stock available is:${AddItemController.instance.stockAvailable.text.trim()}');
    print(
        'track expiry is: ${AddItemController.instance.trackExpiry.text.trim()}');
    print('Expiery is: ${AddItemController.instance.expiryAlert.text.trim()}');
  }
}
