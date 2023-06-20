import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  static AddCategoryController get instance => Get.put(
        AddCategoryController(),
      );
  final TextEditingController categoryName = TextEditingController();
  RxList<String> cartItems = <String>[].obs;
}
