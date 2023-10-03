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
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future saveStoreData() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    // Box storeBox = await Hive.openBox<StoreModel>('store');
    print(
        ' THE PRESENT VALUE OF NOSTOREYET IS ${storeController.noStoreYet.value} BEFORE ADDING A STORE');

    // create a new store
    StoreModel newStore = StoreModel(
      logo: StoreController.instance.logo.value,
      storeName: storeController.storeName.text.trim(),
      bankName: storeController.bankName.text.trim(),
      accountNumber: storeController.accountNumber.text.trim(),
      contact: storeController.contact.text.trim(),
      stock: RxList([]),
      receipts: [],
      debts: [],
      staff: [],
      sales: [],
      customer: [],
      categories: [],
      storeId: const Uuid().v4(),
    );

    // add the new store to hive
    try {
      await storeBox.put(
        'store-${newStore.storeId}',
        newStore,
      );
      storeController.setNoStore();
      storeController.stores.add(newStore);
      print(
          ' THE PRESENT VALUE OF NOSTOREYET IS ${storeController.noStoreYet.value} AFTER ADDING A STORE');
      Get.back();

      Get.snackbar(
        '${storeController.storeName.text.trim()} created',
        '${storeController.storeName.text.trim()} store created successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } catch (e) {
      Get.snackbar(
        'Error creating ${storeController.storeName.text.trim()} store',
        e.toString(),
        // 'An error occured creating ${storeController.storeName.text.trim()}',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

  // // save store data to firebase
  // saveStoreDataToFireBase({
  //   required BuildContext context,
  //   required File logo,
  // }) async {
  //   SharedPreferences access = await SharedPreferences.getInstance();
  //   final uid = access.getString('uid') ?? '';

  //   try {
  //     await saveImageToStorage('storelogo/$uid', logo);
  //     final userDoc = _fireStore.collection('users').doc(uid);
  //     DocumentSnapshot userSnapshot = await userDoc.get();
  //     List<dynamic> currentStores = userSnapshot.get('stores') ?? [];

  //     // create a new store
  //     StoreModel newStore = StoreModel(
  //       logo: StoreController.instance.logo.value,
  //       storeName: StoreController.instance.storeName.text.trim(),
  //       bankName: StoreController.instance.bankName.text.trim(),
  //       accountNumber: StoreController.instance.accountNumber.text.trim(),
  //       contact: StoreController.instance.contact.text.trim(),
  //       stock: RxList([]),
  //       receipts: [],
  //       debts: [],
  //       staff: [],
  //       sales: [],
  //       customer: [],
  //       categories: [],
  //       storeId: const Uuid().v4(),
  //     );

  //     currentStores.add(newStore.toMap());

  //     userDoc.update({'stores': currentStores});

  //     print('NEW FIREBASE STORES $currentStores');
  //     print('FIREBASE STORES ${userSnapshot.toString()}');

  //     // await userDoc.update({'stores': currentStores});

  //     print('Store added to firebase');
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(
  //       context,
  //       e.message.toString(),
  //     );
  //   }
  // }

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
