import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/check_out_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_main_display.dart';
import 'package:spacemall/src/features/core_app/profile/screens/profile_screen.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;

  final List<Widget> screens = const [
    Center(
      child: DashboardGrid(),
    ),
    Center(
      child: CheckOut(),
    ),
    Center(
      child: ProfileScreen(),
    ),
    Center(
      child: AddStore(),
      // SettingsHome(),
    ),
  ];

  void setIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }

  void increamentIndex() {
    selectedIndex.value + 1;
    update();
  }

  void setSelectedIndex(int activeSelectedIndex) =>
      selectedIndex.value = activeSelectedIndex;
}
