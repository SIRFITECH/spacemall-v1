import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/check_out_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_main_display.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/profile/screens/profile_screen.dart';

import '../../../check_out/data/check_out_repo.dart';
import '../../dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import '../screens/dashboard_navbar.dart';

class NavBarController extends GetxController {
  final addCategoryController = Get.put(AddCategoryController());
  final checkOutController = Get.put(CheckOutController());
  final checkOutRepo = Get.put(CheckOutRepo());

  final selectedIndex = 0.obs;
  final selectedMallIndex = 0.obs;

  final List<Widget> screens = [
    const Center(
      child: DashboardGrid(),
    ),
    const Center(
      child: CheckOut(),
    ),
    const Center(
      child: ProfileScreen(),
    ),
    const SpacemallDrawer(),
  ];

  List screen = [
    const DashBoardNavBar(),
    const Center(
      child: CheckOut(),
    ),
    const SpacemallDrawer(),
  ];

  final List<Widget> mallScreens = const [
    Center(
      child: Center(
        child: Text(
          'Wallet Screen',
        ),
      ),
    ),
    Center(
      child: Text(
        ' CheckOut()',
      ),
    ),
    Center(
      child: Text(
        'ProfileScreen()',
      ),
    ),
    Center(
      child: Text(
        ' SettingsScreen()',
      ),
    ),
  ];
  void setIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }

  void setMallIndex(int newIndex) {
    selectedMallIndex.value = newIndex;
  }

  void increamentIndex() {
    selectedIndex.value + 1;
    update();
  }

  void increamentMallIndex() {
    selectedMallIndex.value + 1;
    update();
  }

  void setSelectedIndex(int activeSelectedIndex) =>
      selectedIndex.value = activeSelectedIndex;

  void setSelectedMallIndex(int activeSelectedMallIndex) =>
      selectedMallIndex.value = activeSelectedMallIndex;
}
