import 'package:flutter/material.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/app_bar_theme.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/divider_theme.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/elevated_button_theme.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/floating_action_button.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/icon_theme.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/input_decoration_theme.dart';
import 'package:spacemall/src/utils/themes/theme_widgets/text_theme.dart';

import '../../constants/colors.dart';

class SAppTheme {
  SAppTheme._();

  // app light theme
  static ThemeData lightTheme = ThemeData(
    primarySwatch: PaletteLight.kThemeColor,
    brightness: Brightness.light,
    textTheme: STextTheme.lightTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevetedButtonTheme,
    inputDecorationTheme: SInputDecorationTheme.lightInputDecorationTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    dividerTheme: SDividerTheme.lightDividerTheme,
    iconTheme: SIconTheme.lightIconTheme,
    floatingActionButtonTheme:
        SFloatingActionButtonTheme.lightFloatingActionButtonTheme,
    // datePickerTheme:
  );

// app dark theme
  static ThemeData darkTheme = ThemeData(
    primarySwatch: PaletteDark.kThemeColor,
    brightness: Brightness.dark,
    textTheme: STextTheme.darkTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevetedButtonTheme,
    dividerTheme: SDividerTheme.darkDividerTheme,
    inputDecorationTheme: SInputDecorationTheme.darkInputDecorationTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    iconTheme: SIconTheme.darkIconTheme,
    floatingActionButtonTheme:
        SFloatingActionButtonTheme.darkFloatingActionButtonTheme,
  );
}
