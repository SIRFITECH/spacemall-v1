import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddModifierController extends GetxController {
  static AddModifierController get instance => Get.find();
  // static AddModifierController get instance => Get.put(
  //       AddModifierController(),
  //     );
  final TextEditingController modifierName = TextEditingController();
  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemPrice = TextEditingController();
  RxList<String> myStrings = <String>[].obs;

  var isAlertShown = true.obs;
}
