import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';

import '../../../utils/themes/themes.dart';

class SpacemallApp extends StatelessWidget {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SAppTheme.lightTheme);

  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme:
          // ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          SAppTheme.lightTheme,
      darkTheme:
          // ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 10),
      home: const ChooseUserType(),
    );
  }
}
