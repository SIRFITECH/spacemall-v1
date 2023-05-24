import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class SCountryListTheme {
  SCountryListTheme._();
  // light divider theme
  static const lightAppBarTheme = CountryListThemeData(
    searchTextStyle: TextStyle(
      color: Colors.black,
    ),
  );
  // dark divider theme
  static const darkAppBarTheme = CountryListThemeData(
    searchTextStyle: TextStyle(
      color: Colors.white,
    ),
  );
}
