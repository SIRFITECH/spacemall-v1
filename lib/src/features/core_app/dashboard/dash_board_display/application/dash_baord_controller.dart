import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxString dropdownValue = 'Sirfimix'.obs;
  final selectedIndex = 0.obs;

  final items = <String>[
    'Sirfimix',
    'Sirfitmunch',
    'Sirfitech',
    'Sabitech',
  ];

// final RxList<String> items = <String>[
//   'Sirfimix',
//     'Sirfitmunch',
//     'Sirfitech',
//     'Sabitech',
// ].obs;

//   void addToList(String item) {
//     items.add(item);
//   }

//   void removeFromList(String item) {
//     items.remove(item);
//   }

  final List<Widget> screens = const [
    Center(
      child: Text('Dashboard() '),
    ),
    Center(
      child: Text('CheckOutAddItem()'),
    ),
    Center(
      child: Text('Profile()'),
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
  }

  void setSelectedIndex(int activeSelectedIndex) =>
      selectedIndex.value = activeSelectedIndex;

  void setStore(newValue) => dropdownValue.value = newValue;
}
