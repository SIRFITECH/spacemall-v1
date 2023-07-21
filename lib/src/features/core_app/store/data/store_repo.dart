import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/colors.dart';

class StoreRepo extends GetxController {
  static StoreRepo get instance => Get.put(StoreRepo());
  late StoreController storeController;

  var logo;

// phone operations

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
    getStoresFromBox().isNotEmpty
        ? StoreController.instance.selectedStore.value =
            getStoresFromBox().first
        : [];

    print('StoreRepo is ready');
  }

  Future saveStoreData() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Box storeBox = await Hive.openBox<StoreModel>('store');
    // create a new store
    StoreModel newStore = StoreModel(
      logo: StoreController.instance.logo.value,
      storeName: storeController.storeName.text.trim(),
      bankName: storeController.bankName.text.trim(),
      accountNumber: storeController.accountNumber.text.trim(),
      contact: storeController.contact.text.trim(),
      stock: [],
      receipts: [],
      debts: [],
      staff: [],
      sales: [],
      customer: [],
      categories: [],
      storeId: const Uuid().v4(),
    );

    // add the new store to hive
    await storeBox.put(
      'store-${newStore.storeId}',
      newStore,
    );
    Get.back();
    storeController.stores.add(newStore);
    Get.snackbar(
      '${storeController.storeName.text.trim()} created',
      '${storeController.storeName.text.trim()} store created successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
  }

  // clear the TextEditingControllers
  clearControllers() {
    StoreController.instance.logo.value = null;
    storeController.storeName.clear();
    storeController.bankName.clear();
    storeController.accountNumber.clear();
    storeController.contact.clear();
  }

  // get stores
  List<StoreModel> getStoresFromBox() {
    List<StoreModel> stores = [];
    for (var key in storeBox.keys) {
      if (key.startsWith('store-')) {
        StoreModel? store = storeBox.get(key);
        if (store != null) {
          stores.add(store);
        }
      }
    }
    return stores;
  }

  Future<void> deleteStoreFromPhone(index) async {
    if (storeBox.isNotEmpty) {
      storeBox.deleteAt(index);
      update();
    }
  }

  // add item to hive

  Future<void> addToHive(StoreModel store) async {
    // StoreController.instance.itemList.add(store);
    await storeBox.put('store-${storeController.storeName}', store);
    update();
  }
}
