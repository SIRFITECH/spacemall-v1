import 'package:get/get.dart';

import '../../../store/data/store_repo.dart';
import '../../../store/domain/store_model.dart';

class DashBoardController extends GetxController {
  // RxString dropdownValue = 'Sirfimix'.obs;
  // final selectedIndex = 0.obs;

  List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  // void setIndex(int newIndex) {
  //   selectedIndex.value = newIndex;
  // }

  // void increamentIndex() {
  //   selectedIndex.value + 1;
  // }

  // void setSelectedIndex(int activeSelectedIndex) =>
  //     selectedIndex.value = activeSelectedIndex;

  // void setStore(newValue) => dropdownValue.value = newValue;
}
