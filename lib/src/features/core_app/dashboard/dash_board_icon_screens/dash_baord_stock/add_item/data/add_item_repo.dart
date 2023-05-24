import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_itme_model.dart';

class AddItemRepo extends GetxController {
  static AddItemRepo get instance => Get.find();

  static AddItemController addItemController = Get.find();

  final itemPic = addItemController.itemPic.value;

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
        );
  }

  ///PHONE OPERATIONS

// save item to
  Future saveDataToPhone() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> itemMapList =
        addItemController.itemList.map((item) {
      // Convert the itemPic to a file path string
      String itemPicPath = item.itemPic?.path ?? '';

      return item.toMap()..['itemPic'] = itemPicPath;
    }).toList();
    // List<Map<String, dynamic>> itemMapList =
    //     addItemController.itemList.map((item) => item.toMap()).toList();

    await localDrive.setStringList(
      "item_list",
      itemMapList.map((itemMap) => jsonEncode(itemMap)).toList(),
    );
  }

// add new stock item
  Future<void> addItemToPhone() async {
    // set the values for each property
    File? itemPic = addItemController.itemPic.value;
    String itemName = addItemController.itemName.text.trim();
    String itemSellingPrice = addItemController.sellingPrice.text.trim();
    String itemCategory = addItemController.categoryValue.value;
    String itemQuantity = addItemController.stockAvailable.text.trim();
    String itemCostPrice = addItemController.costPrice.text.trim();
    bool trackProfit = addItemController.trackProfit.value;
    bool trackLowStock = addItemController.trackLowStock.value;
    bool preventItemSalesWhenOutOfStock =
        addItemController.preventItemSalesWhenOutOfStock.value;
    String trackExpiry = addItemController.trackExpiry.text.trim();
    String expiryAlert = addItemController.expiryAlert.text.trim();

    // create a new item
    AddItemModel newItem = AddItemModel(
      itemPic: itemPic,
      itemName: itemName,
      itemSellingPrice: itemSellingPrice,
      itemCategory: itemCategory,
      itemQuantity: itemQuantity,
      itemCostPrice: itemCostPrice,
      trackProfit: trackProfit,
      trackLowStock: trackLowStock,
      preventItemSalesWhenOutOfStock: preventItemSalesWhenOutOfStock,
      trackExpiry: trackExpiry,
      expiryAlert: expiryAlert,
    );

    // add the newTem to the item List
    addItemController.addItem(newItem);
    print('Item added to  itemList in addItemContriller');

    // Save the updated list to SharedPreferences
    await saveDataToPhone().then((value) => clearControllers());
  }

  // clear the TextEditingControllers
  clearControllers() {
    // Clear the text editing controllers
    addItemController.itemName.clear();
    addItemController.sellingPrice.clear();
    addItemController.stockAvailable.clear();
    addItemController.costPrice.clear();
    addItemController.trackExpiry.clear();
    addItemController.expiryAlert.clear();
// Reset other variables
    addItemController.itemPic.value = null;
    addItemController.categoryValue.value = 'Category';
    addItemController.trackProfit.value = false;
    addItemController.trackLowStock.value = false;
    addItemController.preventItemSalesWhenOutOfStock.value = false;
  }

  Future<List<AddItemModel>?> getDataFromPhone() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();
    List<String>? itemJsonList = localDrive.getStringList('item_list');

    if (itemJsonList != null) {
      List<AddItemModel> itemList = itemJsonList.map((itemJson) {
        Map<String, dynamic> itemData = jsonDecode(itemJson);
        // Convert the itemPic back to a File object
        File? itemPic = File(itemData['itemPic']);

        return AddItemModel(
          itemPic: itemPic,
          itemName: itemData['itemName'],
          itemCategory: itemData['itemCategory'],
          itemQuantity: itemData['itemQuantity'],
          expiryAlert: itemData['expiryAlert'],
          itemCostPrice: itemData['itemCostPrice'],
          itemSellingPrice: itemData['itemSellingPrice'],
          preventItemSalesWhenOutOfStock: false,
          trackExpiry: itemData['trackExpiry'],
          trackLowStock: false,
          trackProfit: false,
        );
      }).toList();

      return itemList.isNotEmpty ? itemList : null;
    }

    return null;
  }

  Future<void> deleteLastItemFromPhone() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();

    // Retrieve the current item list from the phone memory
    List<String>? itemJsonList = localDrive.getStringList('item_list');

    if (itemJsonList != null) {
      // Convert the JSON strings to a list of maps
      List itemList =
          itemJsonList.map((itemJson) => jsonDecode(itemJson)).toList();

      // Check if there are any items in the list
      if (itemList.isNotEmpty) {
        // Remove the last item from the list
        itemList.removeLast();

        // Convert the updated list back to JSON strings
        List<String> updatedItemJsonList =
            itemList.map((itemMap) => jsonEncode(itemMap)).toList();

        // Save the updated list to the phone memory
        await localDrive.setStringList('item_list', updatedItemJsonList);
      }
    }
  }

//   Future<void> deleteLastItemFromPhone() async {
//   List<Map<String, dynamic>> itemList = await getDataFromPhone();
//   if (itemList.isNotEmpty) {
//     itemList.removeLast();
//     SharedPreferences localDrive = await SharedPreferences.getInstance();

//     List<String> itemJsonList = itemList.map((itemMap) {
//       return jsonEncode(itemMap);
//     }).toList();

//     await localDrive.setStringList("item_list", itemJsonList);
//   }
// }

  deleteItem() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();
  }

//     // Create an instance of AddItemModel
//     AddItemModel item = AddItemModel(
//       itemPic: itemPic,
//       itemName: itemName,
//       itemCategory: itemCategory,
//       itemQuantity: itemQuantity,
//       itemPrice: itemPrice,
//     );

//     // Use the item data to display in your card or any other UI element
//     // For example:
//     print('Item Name: ${item.itemName}');
//     print('Item Category: ${item.itemCategory}');
//     // ...
//   }
// }

  ///DATABASE OPERATIONS
}
