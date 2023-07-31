import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';

class SAppBarTheme {
  SAppBarTheme._();
  // light divider theme
  static const lightAppBarTheme = AppBarTheme(
      backgroundColor: kLightModeBackgroundColor,
      foregroundColor: kWhiteLight,
      iconTheme: IconThemeData(color: kLightModeBackgroundColor));
  // dark divider theme
  static const darkAppBarTheme = AppBarTheme(
      backgroundColor: kDarkModeDashboardAppbarColor,
      iconTheme: IconThemeData(color: kDarkModeDashboardAppbarColor));
}
