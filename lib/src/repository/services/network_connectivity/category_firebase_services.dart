import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositoies/remote_db_interface/category_remote_db_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../hive_boxes.dart';

class CategoryFirebaseServices extends CategoryRemoteDataBaseAdapter {
  final AddCategoryController _addCategoryController = Get.find();
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
  Future<void> saveCategoryToDB(
      {required CategoryModel newCategory, required Function onSucess}) async {
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
      // currentUserStoresMap['categories'];

      List<dynamic> currentCategory = currentUserStoresMap['categories'];

      currentCategory.add(newCategory.toMap());

      _fireStore
          .collection('stores')
          .doc(_store.storeId)
          .update({'categories': currentCategory}).then(
        (value) => onSucess(),
      );

      _addCategoryController.isLoading.value = false;
    } catch (e) {
      _addCategoryController.isLoading.value = false;
      debugPrint(
          ' Error from saveCategoryToDB() from CategoryFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding Category to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }

  // delete item from remote server
  Future<void> editCategoryInFirebase(CategoryModel newCategory) async {}

  @override
  Future<void> deleteCategoryFromDB(int categoryIndex) async {
    try {
      // get the exixting store
      // get the categories inside the store
      // add the new category to the store
      // update the store back

      final currentUserStores =
          await _fireStore.collection('stores').doc(_store.storeId).get();

      final currentUserStoresMap =
          currentUserStores.data() as Map<String, dynamic>;
      // currentUserStoresMap['categories'];

      List<dynamic> currentCategory = currentUserStoresMap['categories'];
      print(currentCategory[categoryIndex]);

      currentCategory.removeAt(categoryIndex);

      _fireStore
          .collection('stores')
          .doc(_store.storeId)
          .update({'categories': currentCategory});

      // _addCategoryController.isLoading.value = false;
    } catch (e) {
      _addCategoryController.isLoading.value = false;
      debugPrint(
          'Error from deleteCategoryFromDB() from CategoryFirebaseServices ${e.toString()}');
      spaceMallSnackBar(
        'Error Delete Category to server',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
