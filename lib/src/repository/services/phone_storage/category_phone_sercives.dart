import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositories/local_db_inteface/category_local_db_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../../features/core_app/store/domain/store_model.dart';
import '../../hive_boxes.dart';

class CategoryPhoneServices extends CategoryLocalDataBaseAdapter {
  final categoryController = AddCategoryController();
  @override
  Future<void> saveCategoryToDevice(CategoryModel newCategory) async {
    final StoreModel store = storeBox.get(
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
    try {
      store.categories.add(newCategory);

      await storeBox.put(AddItemRepo.instance.currentStore.value, store);

      categoryController.categories.add(newCategory);
      categoryController.categoryName.clear();
      categoryController.noCategory.value = false;
      Get.back();

      spaceMallSnackBar(
        '${categoryController.categoryName.text} added',
        '${categoryController.categoryName.text} category added successfully',
        kBlack,
        kWhiteLight,
      );
    } catch (e) {
      debugPrint(
          'error in the saveCategoryToDevice() when trying to save category to hive, error is: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCategoryFromDevice(int categoryIndex) async {
    final StoreModel store = storeBox.get(
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

    try {
      if (categoryIndex > store.categories.length) {
        spaceMallSnackBar('Invalid selection',
            'You can not delet this category', kWhiteLight, kRedColor);
      } else {
        store.categories.removeAt(categoryIndex);
        await storeBox.deleteAt(categoryIndex);

        Get.back();

        spaceMallSnackBar(
          'Category Deleted',
          'Category Deleted successfully',
          kBlack,
          kWhiteLight,
        );
      }
    } catch (e) {
      debugPrint(
          'Error in the deleteCategoryFromDevice() when trying to delete category from phone, error is: ${e.toString()}');

      spaceMallSnackBar(
        'Error Deleting category ',
        'You cannot delete catefory that does not exist',
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
