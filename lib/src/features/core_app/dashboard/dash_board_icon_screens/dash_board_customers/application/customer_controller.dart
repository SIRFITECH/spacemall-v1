import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';

class CustomersController extends GetxController {
  static CustomersController get instance => Get.find();

  List<CustomerModel> convertCustomers(List customersFromDb) {
    List<CustomerModel> result = [];
    for (var item in customersFromDb) {
      CustomerModel.fromMap(item);
    }
    return result;
  }
}
