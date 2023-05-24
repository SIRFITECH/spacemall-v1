import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';

class SInputDecorationTheme {
  SInputDecorationTheme._();

  // light theme inputdecoration
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(kFormBorderRadius),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: kMainColorLight),
    ),
  );

  // dark theme inputdecoration
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: kMainColorLight),
      borderRadius: BorderRadius.all(
        Radius.circular(kFormBorderRadius),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: kMainComplimemtColorLight),
    ),
  );
}
