import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/data/check_out_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../store/application/store_controller.dart';
// import 'package:showcaseview/showcaseview.dart';
// import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

// import '../../../../../utils/helpers/global_keys.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final BuildContext context;

  DashBoardController(this.context);
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  @override
  void onInit() {
    super.onInit();
    ever(
        CheckOutRepo.instance.count,
        (callback) => print(
            'Testing the count in checkout repo is ${CheckOutRepo.instance.count}'));
    ever(
      StoreController.instance.noStoreYet,
      (callback) => print(
          'noStoreYet has changed to ${StoreController.instance.noStoreYet}'),
    );
    ever(
        AddCategoryController.instance.noCategory,
        (callback) => print(
            'noCategory has changed to ${AddCategoryController.instance.noCategory}'));
    ever(
        AddItemRepo.instance.stockList,
        (callback) => print(
            'Stock list has changed to ${AddItemRepo.instance.stockList}'));
    print('Dashbaord init controller');
  }

  RxString todaySales = ''.obs;
  DateTime selectedDate = DateTime.now();
}
