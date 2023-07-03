import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';

class AddCategoryController extends GetxController {
  static AddCategoryController get instance => Get.find();

  final TextEditingController categoryName = TextEditingController();
  // category dropdown
  RxString categoryValue = 'New Category'.obs;
  void setCategory(String? newValue) {
    if (newValue == 'New Category') {
      Get.to(() => const AddCategory());
    } else {
      categoryValue.value = newValue!;
    }
  }

  RxList<String> categoryItems = <String>[
    'New Category',
  ].obs;

  removeCategory(index) {
    Get.snackbar(
      '${categoryItems[index]} removed',
      '${categoryItems[index]} category removed successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    categoryItems.removeAt(index);
  }

  addNewCategory() {
    if (categoryName.text.isEmpty) {
      Get.snackbar(
        'Error',
        'You can not add an empty category',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      categoryItems.add(categoryName.text);
      Get.snackbar(
        '${categoryName.text} added',
        '${categoryName.text} category added successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
      print(categoryItems);
    }
  }
}
