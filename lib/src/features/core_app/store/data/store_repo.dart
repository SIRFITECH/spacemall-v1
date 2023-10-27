import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/colors.dart';
import '../../../../repository/services/network_connectivity/network_connectivity.dart';
import '../../../../repository/services/network_connectivity/store_firebase_services.dart';
import '../../../../repository/services/phone_storage/store_phone_services.dart';
import '../../../../utils/app_utils/appp_utils.dart';
import '../../../auth/data/auth_repo/auth_repo.dart';

class StoreRepo extends GetxController {
  static StoreRepo get instance => Get.put(StoreRepo());
  late StoreController storeController;
  final AuthRepo authRepo = Get.find();

  late File logo;

  saveStore(BuildContext context) async {
    bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();
    if (deviceHasInternet) {
      StoreController.instance.logo.value;
      logo = storeController.logo.value!;

      StoreModel newStore = StoreModel(
        logoLocalPath: '',
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
        logoRemotePath: '',
      );
      const Center(
        child: CircularProgressIndicator(),
      );
      if (storeController.logo.value != null) {
        try {
          StoreFirebaseServices()
              .saveStoreToDB(
                  newStore: newStore,
                  logo: logo,
                  onSucess: () {
                    StorePhoneServices().saveStoreDataToDevice(newStore);
                  })
              .then((value) {
            spaceMallSnackBar(
              'Success!!',
              'You have added a store with  store name ${newStore.storeName.toUpperCase()}',
              kWhiteLight,
              kGreenColor,
            );
            Get.to(
              () => DashBoard(),
            );
          });
        } catch (e) {
          debugPrint(e.toString());

          spaceMallSnackBar(
            'Error',
            e.toString(),
            kWhiteDark,
            kRedColor,
          );
        }
      } else {
        Get.snackbar('Store must have a logo', 'You have to add a store logo',
            backgroundColor: kRedColor, colorText: kWhiteLight);
      }
    } else {
      spaceMallSnackBar(
        'Add Store Error',
        'Seems you lost connection, please check you internet',
        kWhiteDark,
        kRedColor,
      );
    }
  }

  clearControllers() {
    StoreController.instance.logo.value = null;
    storeController.storeName.clear();
    storeController.bankName.clear();
    storeController.accountNumber.clear();
    storeController.contact.clear();
  }

  // get stores from phone
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

// delete store from phone
  Future<void> deleteStoreFromPhone(index) async {
    if (storeBox.isNotEmpty) {
      storeBox.deleteAt(index);
      update();
    }
  }

  // add item to hive
  Future<void> addToHive(StoreModel store) async {
    await storeBox.put('store-${storeController.storeName}', store);
    update();
  }
}
