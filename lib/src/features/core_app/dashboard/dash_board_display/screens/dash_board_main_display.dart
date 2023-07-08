import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_icons.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/screens/store_front.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

import '../../dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    // final addItemRepo =
    Get.put(
      AddItemRepo(),
    );
    Get.put(
      StoreRepo(),
    );

    return Scaffold(
      backgroundColor: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.only(top: 80),
            children: [
              // stocks icon
              GestureDetector(
                onTap: () {
                  Get.to(() => const Stock());
                },
                child: DashBoardIcon(
                  isDarkMood: isDarkMood,
                  image: kStockIcon,
                  title: kDashbaordStockText,
                ),
              ),
              // Reports icon
              GestureDetector(
                onTap: () {
                  Get.to(() => const SetProfile());
                },
                child: DashBoardIcon(
                  title: kDashbaordReportsText,
                  image: kReportIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // sales icon
              GestureDetector(
                onTap: () {
                  Get.to(() => " const Profile()");
                },
                child: DashBoardIcon(
                  title: kDashbaordSalesText,
                  image: kSalesIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // customer icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Text(' const Customer()')));
                },
                child: DashBoardIcon(
                  title: kDashbaordCustomersText,
                  image: kCustomerIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // staff icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Text('const Staff()'),
                    ),
                  );
                },
                child: DashBoardIcon(
                  title: kDashbaordStaffText,
                  image: kStaffIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // receipts icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Text('const ReceiptList()')));
                },
                child: DashBoardIcon(
                  title: kDashbaordReceiptsText,
                  image: kReceiptIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // debts icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Text('const Debt()')));
                },
                child: DashBoardIcon(
                  title: kDashbaordDebtsText,
                  image: kDebtBookIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // social icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Text('const Socials()')));
                },
                child: DashBoardIcon(
                  title: kDashbaordSocialsText,
                  image: kSocialIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
              // shopfront icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StoreFront(),
                    ),
                  );
                },
                child: DashBoardIcon(
                  title: kDashbaordShopfrontText,
                  image: kMallIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
            ]),
      ),
    );
  }
}
