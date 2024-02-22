import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/data/check_out_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/application/customer_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/application/nav_bar_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bottom_nav_bar_screen.dart';

import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

import '../../dash_board_icon_screens/dash_board_staff/application/staff_controller.dart';
import '../application/dash_baord_controller.dart';

class DashBoard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DashBoard({super.key});

  final navBarController = NavBarController();
  final checkOutRepo = Get.put(CheckOutRepo());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;

    Get.put(
      StoreRepo(),
    );
    Get.put(
      SalesController(),
    );
    Get.put(
      DashBoardController(context),
    );
    Get.put(
      StaffController(),
    );
    Get.put(
      CustomersController(),
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
      body: GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (navBarController) {
          return navBarController.screen[navBarController.selectedIndex.value];
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
