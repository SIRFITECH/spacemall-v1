import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final BuildContext context;

  DashBoardController(this.context);
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  @override
  void onInit() {
    super.onInit();

    StoreController.instance.setNoStoreYet = true.obs;
    // StoreService().addNewStoreToFirebase();
  }

  RxString todaySales = ''.obs;
  DateTime selectedDate = DateTime.now();
}
