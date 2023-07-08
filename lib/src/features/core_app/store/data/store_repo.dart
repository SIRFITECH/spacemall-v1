import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/colors.dart';

class StoreRepo extends GetxController {
  static StoreRepo get instance => Get.put(StoreRepo());
  late StoreController storeController;

  // var logo = StoreController.instance.logo;
  var logo;
// phone operations

  Future saveStoreData() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

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
      storeId: const Uuid().v4(),
    );

// add the new store to hive
    await storeBox.put(
      'store',
      newStore,
    );
    Get.off(() => DashBoard());
    storeController.stores.add(newStore);
    Get.snackbar(
      '${storeController.storeName.text.trim()} created',
      '${storeController.storeName.text.trim()} store created successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    storeController.isStoreAdded.value = true;
  }

  // clear the TextEditingControllers
  clearControllers() {
    StoreController.instance.logo.value = null;
    storeController.storeName.clear();
    storeController.bankName.clear();
    storeController.accountNumber.clear();
    storeController.contact.clear();
  }

// fetch saved stores from phone storage
  Future<List<StoreModel>> getStoresFromPhone() async {
    List<StoreModel> stores = await storeBox.get('store', defaultValue: null);
    return stores;
  }

  Future<void> deleteStoreFromPhone(index) async {
    if (storeBox.isNotEmpty) {
      storeBox.deleteAt(index);
      update();
    }
  }

  /*

  var logo = StoreController.instance.logo;

  StoreModel? _userModel;
  StoreModel get userModel {
    return _userModel ??
        StoreModel(
          logo: logo.value,
          storeName: storeController.storeName.text.trim(),
          bankName: storeController.bankName.text.trim(),
          accountNumber: storeController.accountNumber.text.trim(),
          contact: storeController.contact.text.trim(),
          storeId: '',
          stock: [],
          receipts: [],
          debts: [],
          staff: [],
          sales: [],
          customer: [],
        );
  }

// store data
  saveStoreData(BuildContext context) async {
    logo = storeController.logo;
    StoreModel store = StoreModel(
      logo: logo.value,
      storeName: storeController.storeName.text.trim(),
      bankName: storeController.bankName.text.trim(),
      accountNumber: storeController.accountNumber.text.trim(),
      contact: storeController.contact.text.trim(),
      storeId: '',
      stock: [],
      receipts: [],
      debts: [],
      staff: [],
      sales: [],
      customer: [],
    );
    // print(
    //     'User role is ${splashController.userRole.value} and phone is ${loginController.phone.value}');
    // if (storeController.logo.value!.path.isNotEmpty) {
    //   const Center(
    //     child: CircularProgressIndicator(),
    //   );
    //   ProfileRepo.instance.saveUserDataToFireBase(
    //     context: context,
    //     userModel: userModel,
    //     logo: storeController.profilePic.value!,
    //     onSucess: () {
    //       // save to phone memory
    //       ProfileRepo.instance.saveDataToPhone(store).then(
    //             (value) => AuthRepo.instance.setSignedIn().then(
    //               (value) {
    //                 Get.offAll(
    //                   DashBoard(),
    //                 );
    //               },
    //             ),
    //           );
    //     },
    //   );
    // } else {
    //   Get.snackbar(
    //     'Error',
    //     'You need to pick a profile photo',
    //     backgroundColor: kWhiteLight,
    //   );
    // }
  }

*/

// add item to hive

  Future<void> addToHive(StoreModel store) async {
    // StoreController.instance.itemList.add(store);
    await storeBox.put('store-${storeController.storeName}', store);
    update();
  }
}
