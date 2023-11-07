import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../utils/themes/themes.dart';
import '../../auth/data/auth_repo/auth_repo.dart';
import '../../auth/screens/splash_screen/splash_screen.dart';
import '../dashboard/dash_board_display/screens/dash_board_screen.dart';

class SpacemallApp extends StatelessWidget {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SAppTheme.lightTheme);

  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 10),
      home: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
          if (index == 4) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
            );
          }
        },
        blurValue: 1,
        builder: Builder(
          builder: (context) => FutureBuilder<bool>(
            future: AuthRepo.instance.checkExistingUser(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return DashBoard();
                } else {
                  return const ChooseUserType();
                }
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        autoPlayDelay: const Duration(seconds: 3),
      ),
    );
  }
}
