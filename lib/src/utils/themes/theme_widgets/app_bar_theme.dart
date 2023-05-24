import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';

class SAppBarTheme {
  SAppBarTheme._();
  // light divider theme
  static const lightAppBarTheme = AppBarTheme(
    backgroundColor: kMainColorLight,
    foregroundColor: kWhiteLight,
  );
  // dark divider theme
  static const darkAppBarTheme = AppBarTheme(
    backgroundColor: kMainComplimemtColorDark,
  );
}
