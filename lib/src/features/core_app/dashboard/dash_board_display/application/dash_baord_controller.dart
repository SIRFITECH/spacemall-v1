import 'package:get/get.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();
  RxString todaySales = ''.obs;
}
