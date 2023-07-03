import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/domain/staff_model.dart';

class StaffController extends GetxController {
  static StaffController get instance => Get.find();

  List<StaffModel> convertStaff(List staffFromDb) {
    List<StaffModel> result = [];
    for (var item in staffFromDb) {
      StaffModel.fromMap(item);
    }
    return result;
  }
}
