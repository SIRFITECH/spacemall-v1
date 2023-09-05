import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:showcaseview/showcaseview.dart';
// import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

// import '../../../../../utils/helpers/global_keys.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final BuildContext context;

  DashBoardController(this.context);
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  // @override
  // void onInit() {
  //   super.onInit();

  //   // StoreRepo.instance.getStoresFromBox().isEmpty
  //   //     ? WidgetsBinding.instance.addPostFrameCallback(
  //   //         (_) {
  //   //           ShowCaseWidget.of(context).startShowCase(
  //   //             [
  //   //               keyOne,
  //   //               keyTwo,
  //   //               keyThree,
  //   //               keyFour,
  //   //               keyFive,
  //   //             ],
  //   //           );
  //   //         },
  //   //       )
  //   //     : null;
  // }

  RxString todaySales = ''.obs;
  DateTime selectedDate = DateTime.now();
}
