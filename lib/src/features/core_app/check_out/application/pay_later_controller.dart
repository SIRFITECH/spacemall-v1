import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayLaterController extends GetxController {
  static PayLaterController get instance => Get.put(
        PayLaterController(),
      );

  final TextEditingController customerName = TextEditingController();
  final TextEditingController paymentDate = TextEditingController();
}
