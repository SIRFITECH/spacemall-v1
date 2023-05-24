import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class STextTheme {
  STextTheme._();
  // light text theme
  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kMainComplimemtColorLight,
        fontWeight: FontWeight.bold,
        fontSize: 37),
    headlineMedium: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kMainComplimemtColorLight,
        fontWeight: FontWeight.bold,
        fontSize: 24),
    headlineSmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
    ),
    titleLarge: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kBrighComplementColor,
        fontWeight: FontWeight.normal,
        fontSize: 20),
    titleMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kBrighComplementColor,
      fontSize: 15,
    ),
    titleSmall: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kBrighComplementColor,
        fontWeight: FontWeight.bold,
        fontSize: 13),
    bodyLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kMainComplimemtColorLight,
        fontSize: 17),
    bodySmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      fontSize: 14,
      color: Colors.black38,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );

  // dark text theme
  static TextTheme darkTextTheme = const TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kMainColorDark,
        fontWeight: FontWeight.bold,
        fontSize: 37),
    headlineMedium: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kMainColorDark,
        fontWeight: FontWeight.bold,
        fontSize: 30),
    headlineSmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorDark,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainColorLight,
    ),
    titleLarge: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kWhiteDark,
        fontWeight: FontWeight.normal,
        fontSize: 20),
    titleMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kWhiteDark,
      fontSize: 15,
    ),
    titleSmall: TextStyle(
        fontFamily: 'Arial Rounded',
        color: kWhiteDark,
        fontWeight: FontWeight.bold,
        fontSize: 13),
    bodyLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kBlackDark,
      fontSize: 17,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Arial Rounded',
      color: kMainComplimemtColorLight,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Arial Rounded',
      fontSize: 14,
      color: Colors.black38,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Arial Rounded',
      color:
          // Colors.white,
          kWhiteDark,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}
