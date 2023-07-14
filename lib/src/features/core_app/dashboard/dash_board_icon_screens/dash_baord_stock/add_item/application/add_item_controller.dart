import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class AddItemController extends GetxController {
  static AddItemController get instance => Get.put(
        AddItemController(),
      );

  static AddItemRepo addItemRepo = Get.put(
    AddItemRepo(),
  );

  var isItemAdded = false.obs;

  var selectedIndex = 0.obs;

  RxBool isPressed = false.obs;
  RxInt numSelectedItems = 0.obs;

  // my initial variable
  RxList<AddItemModel> itemList = <AddItemModel>[].obs;

  void setPressed() {
    isPressed.value = true;
    update();
  }

  void increaementSelectedItem(int tapedIndex, int index) {
    if (tapedIndex == index
        // && isPressed.isTrue
        ) {
      AddItemController.instance.numSelectedItems.value++;
    }
  }

  void decreaementSelectedItem(int tapedIndex) {
    if (tapedIndex >= 0) {
      selectedIndex--;
    }
  }

  final moreImages = <String>[
    "Image 1",
    "Image 2",
    "Image 3",
    "Image 4",
  ];

  printItemList() {
    // print(itemList.length);
  }

  Rx<File?> itemPic = Rx(null);
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
    update();
  }

  void setLowStockTracking() {
    trackLowStock.value = !trackLowStock.value;

    update();
  }

  void setPreventItemSalesWhenOutOfStockTracking() {
    preventItemSalesWhenOutOfStock.value =
        !preventItemSalesWhenOutOfStock.value;
    update();
  }

  void selectItemImage(BuildContext context) async {
    itemPic.value = (await pickImage(context));
    update();
  }

  List<AddItemModel> convertStockItems(List stockFromDb) {
    List<AddItemModel> result = [];
    for (var item in stockFromDb) {
      AddItemModel.fromMap(item);
    }
    return result;
  }

  getItemPic() {}

  Future<void> addItemToPhone() async {
    addItemRepo.saveItemData().then((value) => Get.offAll(() => const Stock()));
  }
}
