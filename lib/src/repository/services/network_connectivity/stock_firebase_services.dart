import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositoies/remote_db_interface/stock_remote_db_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../hive_boxes.dart';

class StockFirebaseServices extends StockRemoteDataBaseAdapter {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final AddCategoryController _addCategoryController = AddCategoryController();

  final StoreModel _store = storeBox.get(
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

  @override
  Future<void> saveStockItemToDB(
      {required AddItemModel stockItem, required Function onSucess}) async {
    _addCategoryController.isLoading.value = true;

    try {
      // get the exixting store
      // get the categories inside the store
      // add the new category to the store
      // update the store back

      final currentUserStores =
          await _fireStore.collection('stores').doc(_store.storeId).get();

      final currentUserStoresMap =
          currentUserStores.data() as Map<String, dynamic>;
      currentUserStoresMap['stock'];

      List<dynamic> currentStock = currentUserStoresMap['stock'];

      currentStock.add(stockItem.toMap());

      await _fireStore
          .collection('stores')
          .doc(_store.storeId)
          .update({'stock': currentStock}).then(
        (value) => onSucess(),
      );

      _addCategoryController.isLoading.value = false;
    } catch (e) {
      _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveStockItemToDB() from StockFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding Stock Item to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  Future<void> getStockFromFirebase() async {}
  Future<void> deleteStockFromFirebase(AddItemModel deleteItem) async {
    _addCategoryController.isLoading.value = true;

    try {
      final currentUserStores =
          await _fireStore.collection('stores').doc(_store.storeId).get();

      final currentUserStoresMap =
          currentUserStores.data() as Map<String, dynamic>;

      // Get the current stock from the database
      List<dynamic> currentStock = currentUserStoresMap['stock'];

      // Check if the stock item already exists
      int existingIndex = currentStock.indexWhere(
        (item) => item['itemId'] == deleteItem.itemId,
      );

      if (existingIndex != -1) {
        // If the item exists, delete it from the list
        currentStock.removeAt(existingIndex);
        await _fireStore
            .collection('stores')
            .doc(_store.storeId)
            .update({'stock': currentStock});

        spaceMallSnackBar(
          'Deleted',
          '${deleteItem.itemName} deleted',
          Colors.green,
          kWhiteLight,
        );

        Get.back();
      } else {
        // If the item does not exist, alert the user that the item does not exist
        // currentStock.add(editedItem.toMap());
        debugPrint('Item not found in the stock list.');
        spaceMallSnackBar(
          'Error Deleting Item',
          'You can not delete non existing item',
          kWhiteLight,
          kRedColor,
        );
      }

      _addCategoryController.isLoading.value = false;
    } catch (e) {
      _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveStockItemToDB() from StockFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding/Editing Stock Item to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  // Future<void> deleteStockItemFromDB(String itemId, Function onSuccess) async {
  //   _addCategoryController.isLoading.value = true;

  //   try {
  //     // Get the existing store
  //     final currentUserStores =
  //         await _fireStore.collection('stores').doc(_store.storeId).get();

  //     final currentUserStoresMap =
  //         currentUserStores.data() as Map<String, dynamic>;

  //     // Get the current stock list
  //     List<dynamic> currentStock = currentUserStoresMap['stock'];

  //     // Find the index of the item to be deleted
  //     int itemIndex =
  //         currentStock.indexWhere((item) => item['itemId'] == itemId);

  //     // If the item is found, remove it from the list
  //     if (itemIndex != -1) {
  //       currentStock.removeAt(itemIndex);

  //       // Update the store with the modified stock list
  //       await _fireStore
  //           .collection('stores')
  //           .doc(_store.storeId)
  //           .update({'stock': currentStock}).then(
  //         (value) => onSuccess(),
  //       );
  //     } else {
  //       debugPrint('Item not found in the stock list.');
  //     }

  //     _addCategoryController.isLoading.value = false;
  //   } catch (e) {
  //     _addCategoryController.isLoading.value = false;
  //     debugPrint('Error from deleteStockItemFromDB(): ${e.toString()}');
  //     spaceMallSnackBar(
  //       'Error Deleting Stock Item from server',
  //       e.toString(),
  //       kWhiteLight,
  //       kRedColor,
  //     );
  //   }
  // }

  @override
  Future<void> editStockInFirebase(AddItemModel editedItem) async {
    _addCategoryController.isLoading.value = true;
    // // print('editing stock in firebase...');

    try {
      final currentUserStores =
          await _fireStore.collection('stores').doc(_store.storeId).get();

      final currentUserStoresMap =
          currentUserStores.data() as Map<String, dynamic>;

      // Get the current stock from the database
      List<dynamic> currentStock = currentUserStoresMap['stock'];

      // Check if the stock item already exists
      int existingIndex = currentStock.indexWhere(
        (item) => item['itemId'] == editedItem.itemId,
      );

      if (existingIndex != -1) {
        // If the item exists, update it
        currentStock[existingIndex] = editedItem.toMap();
      } else {
        // If the item does not exist, add it to the stock
        currentStock.add(editedItem.toMap());
      }

      // // Update the stock in the database
      await _fireStore
          .collection('stores')
          .doc(_store.storeId)
          .update({'stock': currentStock});

      spaceMallSnackBar(
        'Edited',
        '${editedItem.itemName} edited',
        Colors.green,
        kWhiteLight,
      );

      Get.back();

      _addCategoryController.isLoading.value = false;
    } catch (e) {
      _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveStockItemToDB() from StockFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding/Editing Stock Item to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
