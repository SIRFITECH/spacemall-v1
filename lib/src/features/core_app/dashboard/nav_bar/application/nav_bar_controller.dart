import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/check_out_screen.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/widgets/check_out_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_main_display.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;

  final List<Widget> screens = const [
    Center(
      child: DashboardGrid(),
    ),
    Center(
      child:
          // CartWidget(),
          CheckOut(),
      // Text('CheckOutAddItem()'),
    ),
    Center(
      child: SetProfile(),
    ),
    Center(
      child: Text('SpacemallDrawer()'),
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
