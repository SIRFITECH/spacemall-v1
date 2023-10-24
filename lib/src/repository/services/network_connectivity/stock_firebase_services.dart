import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositoies/remote_db_interface/stock_remote_db_adapter.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../hive_boxes.dart';

class StockFirebaseServices extends StockRemoteDataBaseAdapter {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
    // _addCategoryController.isLoading.value = true;

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

      // _addCategoryController.isLoading.value = false;
    } catch (e) {
      // _addCategoryController.isLoading.value = false;
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
  Future<void> deleteStockFromFirebase() async {}
  Future<void> editStockInFirebase() async {}
}
