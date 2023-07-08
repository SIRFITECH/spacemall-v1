import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_customer_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_low_stock_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_sales_summary_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/application/nav_bar_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bottom_nav_bar_screen.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final navBarController = NavBarController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    Get.put(
      StoreRepo(),
    );

    return Scaffold(
      backgroundColor:
          isDarkMood ? kDarkModeBackgroundColor : kLightModeBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenSize.height * 0.3,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(kBackGroundCart),
                  fit: BoxFit.fitHeight,
                  scale: 10.0,
                  alignment: Alignment.centerRight,
                ),
                color: isDarkMood
                    ? kDarkModeDashboardAppbarColor
                    : kLightModeDashboardAppbarColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDashBoardAppBarPaddingVertical,
                    horizontal: kDashBoardAppBarPaddingHorizontal),
                child: Column(
                  children: [
                    DashBaordLowStockWidget(isDarkMood: isDarkMood),
                    SizedBox(
                      height: media.size.height * 0.04,
                    ),
                    DashBoardCustomerWidget(isDarkMood: isDarkMood),
                  ],
                ),
              ),
            ),
            GetBuilder<NavBarController>(
              init: NavBarController(),
              builder: (navBarController) => Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.3,
                  bottom: screenSize.height * 0.0027,
                ),
                child: navBarController
                    .screens[navBarController.selectedIndex.value],
              ),
            ),
            DashBoardSalesSummary(isDarkMood: isDarkMood),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
