import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';

class SFloatingActionButtonTheme {
  SFloatingActionButtonTheme._();

// light button theme
  static const lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    foregroundColor: kWhiteLight,
    backgroundColor: kDarkModeIconColor,
  );

// dark button theme
  static const darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    foregroundColor: kBlack,
    backgroundColor: kWhiteLight,
  );
}
