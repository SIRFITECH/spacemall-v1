import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

class AddItemRepo extends GetxController {
  static AddItemRepo get instance => Get.find();

  static AddItemController addItemController = Get.find();

  final itemPic = addItemController.itemPic.value;
// add uuid to each item to identify it uniquely throughout the app
  // String genItemId = '';

  AddItemModel? _addItemModel;
  AddItemModel get addItemModel {
    return _addItemModel ??
        AddItemModel(
          itemPic: addItemController.itemPic.value,
          itemName: addItemController.itemName.text.trim(),
          itemSellingPrice: addItemController.sellingPrice.text.trim(),
          itemCategory: addItemController.categoryValue.value,
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
        );
  }

  ///PHONE OPERATIONS
  ///
  ///
  ///
  ///
  ///
  ///

  Future saveItemData() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // create a new item
    AddItemModel newItem = AddItemModel(
      itemPic: addItemController.itemPic.value,
      itemName: addItemController.itemName.text.trim(),
      itemSellingPrice: addItemController.sellingPrice.text.trim(),
      itemCategory: addItemController.categoryValue.value,
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
    );

    await stockItemBox.put(
        'item-${addItemController.itemName.text.trim()}', newItem);

    Get.to(() => const Stock());
    print(newItem.itemId);
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
    addItemController.categoryValue.value = 'Category';
    addItemController.trackProfit.value = false;
    addItemController.trackLowStock.value = false;
    addItemController.preventItemSalesWhenOutOfStock.value = false;
  }

// fetch saved data from phone storage
  Future<List<AddItemModel>> getDataFromPhone() async {
    List<AddItemModel> itemList =
        await stockItemBox.get('item_list', defaultValue: null);
    return itemList;
  }

  Future<void> deleteLastItemFromPhone() async {
    if (stockItemBox.isNotEmpty) {
      stockItemBox.deleteAt(stockItemBox.length - 1);
      update();
    }
  }

// // print the hive box

//   void printHiveBox(Box box) {
//     for (var key in box.keys) {
//       var item = box.get(key);
//       var value = box.keys;
//       print(item.toString());
//       print(value.toList());
//     }
//   }

  ///DATABASE OPERATIONS
}
