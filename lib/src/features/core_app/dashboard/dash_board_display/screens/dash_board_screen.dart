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
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';

import '../../../../../constants/text_strings.dart';
// import '../../dash_board_icon_screens/dash_board_sales/data/sales_repo.dart';

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

    final StoreRepo storeRepo = StoreRepo();

    return Scaffold(
      backgroundColor: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenSize.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: isDarkMood
                      ? const AssetImage(kBackGroundCart)
                      : const AssetImage(kBackGroundCartDarkMood),
                  fit: BoxFit.contain,
                  scale: 10.0,
                  alignment: Alignment.centerRight,
                  opacity: isDarkMood ? 0.4 : 0.5,
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      color: isDarkMood
                          ? kDarkModeBackgroundColor.withOpacity(0.1)
                          : kLightModeBackgroundColor.withOpacity(0.1),
                      height: screenSize.height * 0.5,
                      child: Obx(() {
                        if (storeRepo.getStoresFromBox().isEmpty &&
                            navBarController.selectedIndex.value !=
                                storeRepo.getStoresFromBox().length) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Get.defaultDialog(
                              backgroundColor: !isDarkMood
                                  ? kDarkModeBackgroundColor.withOpacity(0.1)
                                  : kWhiteDark.withOpacity(0.1),
                              title: kAddStoreAppBarText,
                              titleStyle: const TextStyle(
                                color: kWhiteLight,
                              ),
                              content: const Text(
                                kAddStoreAlertBodyText,
                                style: TextStyle(
                                  color: kWhiteLight,
                                ),
                              ),
                              confirm: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const AddStore());
                                },
                                child: const Text(kOkayText),
                              ),
                            );
                          });
                        }

                        return navBarController
                            .screens[navBarController.selectedIndex.value];
                      }),
                    ),
                  ),
                ),

                // navBarController
                //     .screens[navBarController.selectedIndex.value]
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
