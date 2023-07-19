import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/data/sales_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

class SalesController extends GetxController {
  static SalesController get instance => Get.find();
  // Get.put(
  //       SalesController(),
  //     );
  SalesRepo salesRepo =
      // Get.find();
      //     Get.put(
      //   SalesRepo(),
      // );
      // SalesRepo salesRepo =
      Get.put(
    SalesRepo(),
  );

  DateTime now = DateTime.now();
  RxString date = DateFormat('d MMM').format(SalesController.instance.now).obs;

  List<SalesModel> convertSales(List salesFromDb) {
    List<SalesModel> result = [];
    for (var item in salesFromDb) {
      SalesModel.fromMap(item);
    }
    return result;
  }
}
