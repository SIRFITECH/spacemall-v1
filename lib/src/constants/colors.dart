import 'package:flutter/material.dart';

// GENERIC COLORS
const kPrimaryColor = Color(0xffCC5500);
const kSecondaryColor = Color(0xff665229);
const kSecondary2Color = Color(0xffffb317);
const kBrighComplementColor = Colors.white;
const kDarkComplementColor = Colors.black;
const kDarkThemeBgColor = Color(0xb3faede6);
const kLightThemeBgColor = Color(0xffffffff);
const kGreyColor = Colors.grey;

// BUTTON COLORS
// LIGHT MOOD BUTTON
const kLightMoodButtonColor = Color(0xffCC5500);
// DARK MOOD BUTTON
const kDarkMoodButtonColor = Color(0xffd9814f);

// LIGHT THEME COLORS
const kMainColorLight = Color(0xffCC5500);
const kMainComplimemtColorLight = Color(0xff665229);
const kBlack = Colors.black;
const kWhiteLight = Colors.white;

// DARK THEME COLORS
const kMainColorDark = Color(0xffd9814f);
const kMainComplimemtColorDark = Color(0x4dde9368);
const kBlackDark = Colors.black54;
const kWhiteDark = Colors.white60;

// ON BOARDING COLORS
const kOnBoardingPage1Color = Color(0xfffaede6);
const kOnBoardingPage2Color = Color(0xffd9814f);
const kOnBoardingPage3Color = Color(0xfffbc00a);

// ON SETPROFILE COLORS
const kTextFieldDarkColor = Color(0x1affffff);
const kTextFieldDarkBorderColor = Color(0xfffbc00a);
const kTextFieldLightBorderColor = Color(0xffd9814f);

// theme color pallete
class PaletteLight {
  static const MaterialColor kThemeColor = MaterialColor(
    0xffCC5500, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x1ace5d1c), //10%
      100: Color(0x33d36f35), //20%
      200: Color(0x4dd9814f), //30%
      300: Color(0x66de9368), //40%
      400: Color(0x80e4a581), //50%
      500: Color(0x99e9b79a), //60%
      600: Color(0xb3efc9b3), //70%
      700: Color(0xccf4dbcd), //80%
      800: Color(0xe6faede6), //90%
      900: Color(0xffffffff), //100%
    },
  );
}

class PaletteDark {
  static const MaterialColor kThemeColor = MaterialColor(
    0xffde9368, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5d1c), //10%
      100: Color(0xffd36f35), //20%
      200: Color(0xffd9814f), //30%
      300: Color(0xffde9368), //40%
      400: Color(0xffe4a581), //50%
      500: Color(0xffe9b79a), //60%
      600: Color(0xffefc9b3), //70%
      700: Color(0xfff4dbcd), //80%
      800: Color(0xfffaede6), //90%
      900: Color(0xffffffff), //100%
    },
  );
}
