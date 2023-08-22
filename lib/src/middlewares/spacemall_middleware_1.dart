import 'package:get/get.dart';

import '../features/core_app/store/application/store_controller.dart';
import '../features/core_app/store/data/store_repo.dart';
import '../features/core_app/store/domain/store_model.dart';

class SpaceMallMiddleWare1 extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  GetPage? onPageCalled(GetPage? page) {
    List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

    // print('>>> Page ${storesFromBox.length} called');
    // print('>>> User ${authController.username} logged');
    storesFromBox.isEmpty
        ? StoreController.instance
            .setStore(StoreController.instance.selectedStore.value)
        : StoreController.instance.setStore(storesFromBox.last);
    return super.onPageCalled(page);
  }
}
