import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class SElevatedButtonTheme {
  SElevatedButtonTheme._();

// light button theme
  static final lightElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      foregroundColor: kWhiteLight,
      backgroundColor: kLightMoodButtonColor,
      padding: const EdgeInsets.all(kButtonHeight),
    ),
  );

// dark button theme
  static final darkElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      foregroundColor: kWhiteLight,
      backgroundColor: kMainComplimemtColorLight,
      // kDarkMoodButtonColor,
      padding: const EdgeInsets.all(kButtonHeight),
    ),
  );
}
