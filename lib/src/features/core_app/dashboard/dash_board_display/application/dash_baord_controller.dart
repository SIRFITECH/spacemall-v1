import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final BuildContext context;

  // final GlobalKey stockKey = GlobalKey();
  // final GlobalKey menuKey = GlobalKey();
  // final GlobalKey addStoreKey = GlobalKey();
  // final GlobalKey addCategoryKey = GlobalKey();
  // final GlobalKey checkOutKey = GlobalKey();
  // final GlobalKey salesSummaryKey = GlobalKey();
  // final GlobalKey storesListKey = GlobalKey();
  // final GlobalKey lowStockKey = GlobalKey();

  DashBoardController(
    this.context,
  );
  // List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();

  @override
  void onInit() {
    super.onInit();

    StoreController.instance.setNoStoreYet = true.obs;
    // StoreService().addNewStoreToFirebase();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   (_) => ShowCaseWidget.of(context).startShowCase([
    //         stockKey,
    //         menuKey,
    //         addStoreKey,
    //         addCategoryKey,
    //         checkOutKey,
    //         salesSummaryKey,
    //         storesListKey,
    //         lowStockKey,
    //       ]);
    // });
  }

  RxString todaySales = ''.obs;
  DateTime selectedDate = DateTime.now();

  // GestureDetector showcaseStockIcon(
  //   GlobalKey<State<StatefulWidget>> key,
  //   bool showCaseStockIcon,
  //   BuildContext context,
  //   DashBoardIcon dashBoardIcon,
  // ) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => Stock());
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 8),
  //       child: Showcase(
  //           key: key,
  //           description: 'Tap to check mail',
  //           tooltipPosition: TooltipPosition.top,
  //           disposeOnTap: true,
  //           onTargetClick: () {
  //             Navigator.push<void>(
  //               context,
  //               MaterialPageRoute<void>(
  //                 builder: (_) => Stock(),
  //               ),
  //             ).then((_) {
  //               ShowCaseWidget.of(context).startShowCase([]);
  //             });
  //           },
  //           child: DashBoardGridIcon(
  //             isDarkMood: false,
  //             screen: Stock(),
  //             dashBoardIcon: dashBoardIcon,
  //           )),
  //     ),
  //   );
  // }
}
