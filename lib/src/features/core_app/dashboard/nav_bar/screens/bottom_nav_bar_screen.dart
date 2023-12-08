import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/application/nav_bar_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bttom_bar_icon_widget.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final NavBarController navBarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    // Get.put(
    //   ReceiptsController(),
    // );
    // Get.put(
    //   CartItemController(),
    // );
    // Get.put(
    //   AddReceiptsRepo(),
    // );

    return BottomAppBar(
      color: isDarkMood ? kDarkModeBackgroundColor : kLightModeBackgroundColor,
      elevation: 0,
      child: SizedBox(
        height: screenSize.height * 0.09,
        width: screenSize.width,
        child: Column(
          children: [
            CustomDivider(
              height: 0,
              thickness: 0.1,
              color: isDarkMood ? kWhiteLight : kLightModeBackgroundColor,
              margin: const EdgeInsets.all(0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 0),
              child: Row(
                children: [
                  SizedBox(
                    width: media.size.width * 0.05,
                  ),
                  // Icon and text for setting
                  Obx(
                    () => BottomBarIcon(
                      text: kMenuIconText,
                      icon: kMenuIcon,
                      selected: navBarController.selectedIndex.value == 2,
                      onPress: () {
                        navBarController.setIndex(2);
                        navBarController.increamentIndex();
                      },
                    ),
                  ),
                  // Icon and text for dashboard
                  Obx(
                    () => BottomBarIcon(
                      text: kDashBoardIconText,
                      icon: kDashBoardIcon,
                      selected: navBarController.selectedIndex.value == 0,
                      onPress: () {
                        navBarController.setIndex(0);
                        navBarController.increamentIndex();
                      },
                    ),
                  ),

                  // Icon and text for checkout
                  Obx(
                    () => BottomBarIcon(
                      text: kCheckOutIconText,
                      icon: kCheckOutIcon,
                      selected: navBarController.selectedIndex.value == 1,
                      onPress: () {
                        navBarController.setIndex(1);
                        navBarController.increamentIndex();
                      },
                    ),
                  ),
                  // // Icon and text for profile
                  // Obx(
                  //   () => BottomBarIcon(
                  //     text: kProfileIconText,
                  //     icon: kProfileIcon,
                  //     selected: navBarController.selectedIndex.value == 2,
                  //     onPress: () {
                  //       navBarController.setIndex(2);
                  //       navBarController.increamentIndex();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MallBottomNavBar extends StatelessWidget {
  MallBottomNavBar({super.key});

  final NavBarController navBarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;

    return BottomAppBar(
      color: isDarkMood ? kDarkModeBackgroundColor : kLightModeBackgroundColor,
      elevation: 0,
      child: SizedBox(
        height: 67,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CustomDivider(
              height: 0,
              thickness: 0.1,
              color: isDarkMood ? kWhiteLight : kLightModeBackgroundColor,
              margin: const EdgeInsets.all(0),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 0,
                left: 0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: media.size.width * 0.05,
                  ),
                  // // Icon and text for dashboard

                  Obx(
                    () => BottomBarIcon(
                      text: kWalletIconText,
                      icon: kWalletIcon,
                      selected: navBarController.selectedMallIndex.value == 0,
                      onPress: () {
                        navBarController.setMallIndex(0);
                        navBarController.increamentMallIndex();
                      },
                    ),
                  ),

                  // Icon and text for checkout
                  Obx(
                    () => BottomBarIcon(
                      text: kCheckOutIconText,
                      icon: kCheckOutIcon,
                      selected: navBarController.selectedMallIndex.value == 1,
                      onPress: () {
                        navBarController.setMallIndex(1);
                        navBarController.increamentMallIndex();
                      },
                    ),
                  ),
                  // Icon and text for profile
                  Obx(
                    () => BottomBarIcon(
                      text: kProfileIconText,
                      icon: kProfileIcon,
                      selected: navBarController.selectedMallIndex.value == 2,
                      onPress: () {
                        navBarController.setMallIndex(2);
                        navBarController.increamentMallIndex();
                      },
                    ),
                  ),
                  // Icon and text for setting
                  Obx(
                    () => BottomBarIcon(
                      text: kSettingIconText,
                      icon: kSettingsIcon,
                      selected: navBarController.selectedMallIndex.value == 3,
                      onPress: () {
                        navBarController.setMallIndex(3);
                        navBarController.increamentMallIndex();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
