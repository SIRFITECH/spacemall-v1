import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_icons.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/screens/customer_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receiptScreen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/report_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/sales_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/screens/shop_front.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_socials/screens/socialsScreen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/screens/staff_screen.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

import '../../dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import '../../dash_board_icon_screens/dash_board_debts/screens/debts_screen.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !isDarkMood
                ? const AssetImage(kBackGroundCart)
                : const AssetImage(kBackGroundCartDarkMood),
            fit: BoxFit.contain,
            scale: 10.0,
          ),
          borderRadius: const BorderRadius.only(
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
                  Get.to(() => const ReportScreen());
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
                  Get.to(() => const SalesScreen());
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
                  Get.to(
                    () => const CustomerScreen(),
                  );
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
                  Get.to(
                    () => const StaffScreen(),
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
                  Get.to(() => const ReceiptListScreen());
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
                  Get.to(() => const DebtScreen());
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
                  Get.to(
                    () => const SocialsScreen(),
                  );
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
                      builder: (context) => const ShopFrontScreen(),
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
