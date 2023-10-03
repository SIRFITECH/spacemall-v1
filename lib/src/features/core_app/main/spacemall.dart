import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    // final themeController = Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode:
          // themeController.theme,
          ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 10),
      // initialBinding: SpaceMallBinding(),

      // initialRoute: '/',
      // onInit: () async {
      //   bool isExistingUser = await AuthRepo.instance.checkExistingUser();
      //   if (isExistingUser) {
      //     Get.offNamed('/dashboard');
      //   } else {
      //     Get.offNamed('/');
      //   }
      // },
      // getPages: [
      //   GetPage(name: '/', page: () => const ChooseUserType()),
      //   GetPage(
      //       name: '/dashboard',
      //       page: () => DashBoard(),
      //       middlewares: [SpaceMallMiddleWare1()]),
      // ],

      home: FutureBuilder<bool>(
        future: AuthRepo.instance.checkExistingUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return DashBoard();
              // ShowCaseWidget(
              //   builder: Builder(
              //     builder: (context) => DashBoard(),
              //   ),
              // );
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
    );
  }
}
