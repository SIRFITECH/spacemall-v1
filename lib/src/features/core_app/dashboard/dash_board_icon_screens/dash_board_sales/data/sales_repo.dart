import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';

class SalesRepo extends GetxController {
  static SalesRepo get instance => Get.put(
        SalesRepo(),
      );

  SalesController salesController = Get.put(SalesController());
}
