import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/check_out_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_main_display.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/profile/screens/profile_screen.dart';

import '../screens/dashboard_navbar.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;
  final selectedMallIndex = 0.obs;

  final List<Widget> screens = [
    Center(
      child: DashboardGrid(),
    ),
    const Center(
      child: CheckOut(),
    ),
    const Center(
      child: ProfileScreen(),
    ),
    const SpacemallDrawer(),
    // Center(child:
    //     // AddStore(),
    //     SettingsScreen(),
    //     ),
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
