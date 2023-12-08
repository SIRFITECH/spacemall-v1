import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositories/remote_db_interface/receipt_remote_db_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../hive_boxes.dart';

class ReceiptFirebaseServices extends ReceiptRemoteDataBaseAdapter {
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
  Future<void> saveNewReceiptToDB(
      {required ReceiptsModel newReceipt, required Function onSucess}) async {
    // _addCategoryController.isLoading.value = true;

    try {
      // get the exixting store
      // get the categories inside the store
      // add the new category to the store
      // update the store back

      // get store data in the current user
      final currentUserStores =
          await _fireStore.collection('stores').doc(_store.storeId).get();

      // convert the store data to Map<String, dynamic>
      final currentUserStoresMap =
          currentUserStores.data() as Map<String, dynamic>;

      // extract the receipts from the store
      List<dynamic> currentReceipts = currentUserStoresMap['receipts'];

      currentReceipts.add(newReceipt.toMap());

      await _fireStore.collection('stores').doc(_store.storeId).update({
        "receipts": currentReceipts,
      }).then((value) => onSucess());

      // _addCategoryController.isLoading.value = false;
    } catch (e) {
      // _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveNewReceiptToDB() from ReceiptFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding Receipt to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  Future<void> getReceiptsFromFirebase() async {}
  Future<void> deleteReceiptFromFirebase() async {}
  Future<void> editReceiptInFirebase() async {}
}
