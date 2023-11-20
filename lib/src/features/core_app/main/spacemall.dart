// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/screens/auth_check/auth_check.dart';
// import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
// import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
// import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';
// import 'package:showcaseview/showcaseview.dart';

import '../../../utils/themes/themes.dart';

class SpacemallApp extends StatelessWidget {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SAppTheme.lightTheme);

  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileController = Get.put(ProfileController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 10),
      home: const AuthCheckScreen(),

      // FutureBuilder<bool>(
      //   future: AuthRepo.instance.checkExistingUser(),
      //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      //     if (snapshot.hasData) {
      //       // Future<UserModel?> user = profileController.getUserDataFromHive();
      //       if (snapshot.data!) {

      //         return
      //         DashBoard();
      //         // user == null ? const SetProfile() :
      //       } else {
      //         return const ChooseUserType();
      //       }
      //       // if (snapshot.data != null && snapshot.data == true) {
      //       //   return const SetProfile();
      //       //   // return DashBoard();
      //       // } else if (snapshot.data != null && snapshot.data == false) {
      //       //   return DashBoard();
      //       //   // return const SetProfile();
      //       // } else {
      //       //   return const ChooseUserType();
      //       // }
      //     }
      //     return const Scaffold(
      //       body: Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     );
      //   },
      // ),

      /// showcase widget

      // ShowCaseWidget(
      //   onStart: (index, key) {
      //     log('onStart: $index, $key');
      //   },
      //   onComplete: (index, key) {
      //     log('onComplete: $index, $key');
      //     if (index == 4) {
      //       SystemChrome.setSystemUIOverlayStyle(
      //         SystemUiOverlayStyle.light.copyWith(
      //           statusBarIconBrightness: Brightness.dark,
      //           statusBarColor: Colors.white,
      //         ),
      //       );
      //     }
      //   },
      //   blurValue: 1,
      //   builder: Builder(
      //     builder: (context) =>

      //      FutureBuilder<bool>(
      //       future: AuthRepo.instance.checkExistingUser(),
      //       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      //         if (snapshot.hasData) {
      //           if (snapshot.data!) {
      //             return DashBoard();
      //           } else {
      //             return const ChooseUserType();
      //           }
      //         }
      //         return const Scaffold(
      //           body: Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         );
      //       },
      //     ),

      //   ),
      //   autoPlayDelay: const Duration(seconds: 3),
      // ),
    );
  }
}
