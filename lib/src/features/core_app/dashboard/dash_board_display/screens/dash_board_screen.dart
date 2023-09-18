import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/application/nav_bar_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bottom_nav_bar_screen.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';

import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

import '../application/dash_baord_controller.dart';

class DashBoard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DashBoard({super.key});

  final navBarController = NavBarController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    Get.put(
      StoreRepo(),
    );
    Get.put(
      SalesController(),
    );
    Get.put(
      DashBoardController(context),
    );

    // final StoreRepo storeRepo = StoreRepo();

    final StoreController storeController = Get.find<StoreController>();
    storeController.noStoreYet.value = false;
    storeController.setNoStore();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
      body: GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (navBarController) {
          // if (storeController.stores.isEmpty ||
          //     storeController.noStoreYet.value == true) {
          //   print('no store yet');
          //   WidgetsBinding.instance.addPostFrameCallback((_) {
          //     Get.defaultDialog(
          //       backgroundColor: !isDarkMood
          //           ? kDarkModeBackgroundColor.withOpacity(0.1)
          //           : kWhiteDark.withOpacity(0.1),
          //       title: kAddStoreText,
          //       titleStyle: const TextStyle(
          //         color: kWhiteLight,
          //       ),
          //       content: const Text(
          //         kAddStoreAlertBodyText,
          //         style: TextStyle(
          //           color: kWhiteLight,
          //         ),
          //       ),
          //       confirm: ElevatedButton(
          //         onPressed: () {
          //           Get.to(() => const AddStore());
          //         },
          //         child: const Text(kOkayText),
          //       ),
          //     );
          //   });
          // }

          return navBarController.screen[navBarController.selectedIndex.value];
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
