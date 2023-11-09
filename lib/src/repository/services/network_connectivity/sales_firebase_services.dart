import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:spacemall/data/repositoies/remote_db_interface/sales_remote_db_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../hive_boxes.dart';

class SalesFirebaseServices extends SalesRemoteDataBaseAdapter {
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
  Future<void> saveNewSalesToDB(
      {required SalesModel newSales, required Function onSucess}) async {
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

      List<dynamic> currentSales = currentUserStoresMap['sales'];

      currentSales.add(newSales.toMap());

      await _fireStore
          .collection('stores')
          .doc(_store.storeId)
          .update({'sales': currentSales}).then(
        (value) => onSucess(),
      );

      // _addCategoryController.isLoading.value = false;
    } catch (e) {
      // _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveNewSaleToDB() from SaleFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Sales to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
