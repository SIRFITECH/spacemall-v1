import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

class SalesController extends GetxController {
  static SalesController get instance => Get.find();

  List<SalesModel> convertSales(List salesFromDb) {
    List<SalesModel> result = [];
    for (var item in salesFromDb) {
      SalesModel.fromMap(item);
    }
    return result;
  }
}
