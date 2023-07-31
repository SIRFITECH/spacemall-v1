import 'package:get/get.dart';

class CartRepo extends GetxController {
  static CartRepo get instance => Get.put(
        CartRepo(),
      );
}
