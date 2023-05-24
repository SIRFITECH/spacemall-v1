import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/application/nav_bar_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bttom_bar_icon_widget.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final NavBarController navBarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;

    return BottomAppBar(
      color: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
      elevation: 0,
      child: SizedBox(
        height: 67,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Row(
            children: [
              SizedBox(
                width: media.size.width * 0.05,
              ),
              // // Icon and text for dashboard

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
              // Icon and text for profile
              Obx(
                () => BottomBarIcon(
                  text: kProfileIconText,
                  icon: kProfileIcon,
                  selected: navBarController.selectedIndex.value == 2,
                  onPress: () {
                    navBarController.setIndex(2);
                    navBarController.increamentIndex();
                  },
                ),
              ),
              // Icon and text for setting
              Obx(
                () => BottomBarIcon(
                  text: kSettingIconText,
                  icon: kSettingsIcon,
                  selected: navBarController.selectedIndex.value == 3,
                  onPress: () {
                    navBarController.setIndex(3);
                    navBarController.increamentIndex();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
