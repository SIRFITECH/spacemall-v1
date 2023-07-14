import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';

class ReceiptsController extends GetxController {
  static ReceiptsController get instance => Get.put(ReceiptsController());

  final RxList<ReceiptsModel> receipts = <ReceiptsModel>[].obs;

  void addReceipt(ReceiptsModel newReceipt) {
    receipts.add(newReceipt);
  }

  RxInt receiptNo = 0.obs;
  RxBool receiptStatus = false.obs; // false = unsuccessful, true = successful

  List<ReceiptsModel> convertReceipts(List receiptsFromDb) {
    List<ReceiptsModel> result = [];
    for (var item in receiptsFromDb) {
      ReceiptsModel.fromMap(item);
    }
    return result;
  }
}
