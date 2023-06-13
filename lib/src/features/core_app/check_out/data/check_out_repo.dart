import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CheckOutRepo extends GetxController {
  static CheckOutRepo get instance => Get.put(
        CheckOutRepo(),
      );
  // final CheckOutRepo checkOutRepo = Get.put(CheckOutRepo());
  // ProfileController profileController = Get.find();
  String itemId = const Uuid().v4();

  void addProductToCart() async {}
}
