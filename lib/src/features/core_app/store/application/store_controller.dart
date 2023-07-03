import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

class StoreController extends GetxController {
  static StoreController get instance => Get.put(StoreController());

  List<StoreModel> convertStores(List storesFromDb) {
    List<StoreModel> result = [];
    for (var item in storesFromDb) {
      StoreModel.fromMap(item);
    }
    return result;
  }
}
