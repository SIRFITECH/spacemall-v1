import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_service.dart';

import '../../../../../repository/services/network_connectivity/network_connectivity.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final BuildContext context;

  DashBoardController(this.context);
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  @override
  void onInit() {
    super.onInit();
    // ever(
    //     isDeviceConnected,
    //     (callback) =>
    //         print('Testing the isDeviceConnected $isDeviceConnected'));
    // ever(
    //   StoreController.instance.noStoreYet,
    //   (callback) => print(
    //       'noStoreYet has changed to ${StoreController.instance.noStoreYet}'),
    // );
    // ever(
    //     AddCategoryController.instance.noCategory,
    //     (callback) => print(
    //         'noCategory has changed to ${AddCategoryController.instance.noCategory}'));
    // ever(
    //     AddItemRepo.instance.stockList,
    //     (callback) => print(
    //         'Stock list has changed to ${AddItemRepo.instance.stockList}'));

    StoreController.instance.setNoStoreYet = true.obs;
    StoreService().addNewStoreToFirebase();

    print(
        'Connection to internet is ${NetworkConnectivity().deviceHasInternet()}');
    print('the value of noStoreYet ${StoreController.instance.noStoreYet}');
    print('Dashbaord init controller');
  }

  // Future<void> getConnectivity() async {
  //   subscription = Connectivity().onConnectivityChanged.listen((event) async {
  //     final hasConnection = await InternetConnectionChecker().hasConnection;
  //     isDeviceConnected.value = hasConnection;

  //     if (!hasConnection && !isAlertOpen) {
  //       Get.snackbar('Network error', 'You are working offline',
  //           colorText: kBlackDark, backgroundColor: Colors.grey[400]);
  //       print('INTERNET NOT CONNECTED');
  //       isAlertOpen = true;
  //     } else if (hasConnection) {
  //       Get.snackbar('Network alert', 'Welcome back online',
  //           colorText: kBlackDark, backgroundColor: Colors.grey[400]);
  //       print('INTERNET CONNECTED');
  //       isAlertOpen = false;
  //     }
  //   });
  // }

  RxString todaySales = ''.obs;
  DateTime selectedDate = DateTime.now();
}
