import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';

class ShopFrontController extends GetxController {
  static ShopFrontController get instance => Get.find();

  /*
simple add string sample
*/
  final TextEditingController storeName = TextEditingController();
  // category dropdown
  RxString storeValue = 'New Store'.obs;
  void setCategory(String? newValue) {
    if (newValue == 'New Category') {
      Get.to(() => const AddCategory());
    } else {
      storeValue.value = newValue!;
    }
  }

  RxList<String> stores = <String>[
    'New Store',
  ].obs;

  removeCategory(index) {
    Get.snackbar(
      '${stores[index]} removed',
      '${stores[index]} category removed successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    stores.removeAt(index);
  }

  addNewCategory() {
    if (storeName.text.isEmpty) {
      Get.snackbar(
        'Error',
        'You can not add an empty category',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      stores.add(storeName.text);
      Get.snackbar(
        '${storeName.text} added',
        '${storeName.text} category added successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    }
  }
}
