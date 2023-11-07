import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_icons.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/screens/customer_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/report_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/sales_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/screens/shop_front.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_socials/screens/socials_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/screens/staff_screen.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

import '../../../../../utils/helpers/showcase.dart';
import '../../dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import '../../dash_board_icon_screens/dash_board_debts/screens/debts_screen.dart';

class DashboardGrid extends StatefulWidget {
  const DashboardGrid({super.key});

  @override
  State<DashboardGrid> createState() => _DashboardGridState();
}

class _DashboardGridState extends State<DashboardGrid> {
  final GlobalKey _stockKey = GlobalKey();
  final GlobalKey menuKey = GlobalKey();
  final GlobalKey addStoreKey = GlobalKey();
  final GlobalKey addCategoryKey = GlobalKey();
  final GlobalKey checkOutKey = GlobalKey();
  final GlobalKey salesSummaryKey = GlobalKey();
  final GlobalKey storesListKey = GlobalKey();
  final GlobalKey lowStockKey = GlobalKey();
  BuildContext? myContext;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      (_) => ShowCaseWidget.of(myContext!).startShowCase([
            _stockKey,
            menuKey,
            addStoreKey,
            addCategoryKey,
            checkOutKey,
            salesSummaryKey,
            storesListKey,
            lowStockKey,
          ]);
    });
    super.initState();
  }

  // This is the dashboard icons on the
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;

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
          // borderRadius: const BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // ),
        ),
        child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.only(top: 80),
            children: [
              // stocks icon
              SpaceMallShowCase(
                  title: 'Follow to add Store',
                  description: 'Tap and add store',
                  globalKey: _stockKey,
                  context: context,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => Stock(),
                      );
                    },
                    child: DashBoardIcon(
                      isDarkMood: isDarkMood,
                      image: kStockIcon,
                      title: kDashbaordStockText,
                    ),
                  )

                  // DashBoardGridIcon(
                  //   isDarkMood: isDarkMood,
                  //   screen: Stock(),
                  //   showCaseStockIcon: true,
                  //   showCaseStockKey: dashBoardController.addStoreKey,
                  //   dashBoardIcon: DashBoardIcon(
                  //     isDarkMood: isDarkMood,
                  //     image: kStockIcon,
                  //     title: kDashbaordStockText,
                  //   ),
                  // ),
                  ),

              // DashBoardGridIcon(
              //   isDarkMood: isDarkMood,
              //   screen: Stock(),
              //   showCaseStockIcon: true,
              //   showCaseStockKey: dashBoardController.addStoreKey,
              //   dashBoardIcon: DashBoardIcon(
              //     isDarkMood: isDarkMood,
              //     image: kStockIcon,
              //     title: kDashbaordStockText,
              //   ),
              // ),

              // Reports icon
              DashBoardGridIcon(
                isDarkMood: isDarkMood,
                dashBoardIcon: DashBoardIcon(
                  title: kDashbaordReportsText,
                  image: kReportIcon,
                  isDarkMood: isDarkMood,
                ),
                screen: const ReportScreen(),
              ),
              // sales icon
              DashBoardGridIcon(
                isDarkMood: isDarkMood,
                screen: const SalesScreen(),
                dashBoardIcon: DashBoardIcon(
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
                  image: kStoreIcon,
                  isDarkMood: isDarkMood,
                ),
              ),
            ]),
      ),
    );
  }
}

// This is the class that builds the dashboard icon in the dashboard grid
class DashBoardGridIcon extends StatelessWidget {
  const DashBoardGridIcon({
    super.key,
    required this.isDarkMood,
    required this.screen,
    required this.dashBoardIcon,
    this.showCaseStockIcon = false,
    this.showCaseStockKey,
  });

  final bool isDarkMood;
  final Widget screen;
  final DashBoardIcon dashBoardIcon;
  final bool showCaseStockIcon;
  final GlobalKey<State<StatefulWidget>>? showCaseStockKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => screen);
      },
      child: dashBoardIcon,
    );
  }
}
