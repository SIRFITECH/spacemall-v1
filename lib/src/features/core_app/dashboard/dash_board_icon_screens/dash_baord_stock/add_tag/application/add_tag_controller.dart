import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTagController extends GetxController {
  static AddTagController get instance => Get.put(
        AddTagController(),
      );
  final variantName = TextEditingController();
  final item = TextEditingController();
  RxList<String> myStrings = <String>[].obs;

  var isAlertShown = true.obs;

  // void showComingSoon() {
  //   isAlertShown.value = true;
  // }
}
