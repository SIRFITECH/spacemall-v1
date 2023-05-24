import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';

class SDividerTheme {
  SDividerTheme._();
  // light divider theme
  static const lightDividerTheme = DividerThemeData(
    thickness: kDividerThickness,
    color: kGreyColor,
  );
  // dark divider theme
  static const darkDividerTheme = DividerThemeData(
    thickness: kDividerThickness,
    color: kMainComplimemtColorLight,
  );
}
