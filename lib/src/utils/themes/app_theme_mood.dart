import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

class ThemeController extends GetxController {
  final _box = appBox;
  // GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool _loadTheme() => _box.get(_key) ?? false;

  void saveTheme(bool isDarkMode) => _box.put(_key, isDarkMode);
  void changeTheme(ThemeData theme) => Get.changeTheme(theme);
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}
