import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/application/report_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/category_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/remaining_stock_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/sales_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: [],
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );
    ReportsController.instance.todayReport.value =
        DateFormat('d MMM').format(DateTime.now());

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: '${store.storeName} $kReportAppBarText',
          automaticallyImplyLeading: false),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMood
              ? kDarkModeBackgroundColor.withAlpha(2)
              : kWhiteLight.withAlpha(2),
          image: DecorationImage(
            image: !isDarkMood
                ? const AssetImage(kBackGroundCart)
                : const AssetImage(kBackGroundCartDarkMood),
            fit: BoxFit.contain,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              // remaining stock
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => const
                        // TopCustomerReport(),
                        // CategoryReport(),
                        // SalesReport(),
                        // ShopfrontReport(),
                        RemainingStock(),
                  );
                },
                child: Center(
                  child: Container(
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: !isDarkMood
                            ? kTextFieldLightBorderColor.withOpacity(0.5)
                            : kTextFieldDarkBorderColor.withOpacity(0.5),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(screenSize.height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kReportRemainingStockText.toUpperCase(),
                            style: TextStyle(
                              color: !isDarkMood ? kBlack : kWhiteDark,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: !isDarkMood
                                ? kBlackDark.withOpacity(0.5)
                                : kTextFieldDarkBorderColor.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              child: Center(
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: !isDarkMood
                          ? kTextFieldLightBorderColor.withOpacity(0.5)
                          : kTextFieldDarkBorderColor.withOpacity(0.5),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(screenSize.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            ReportsController.instance.pickYesterday(
                              context,
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (defaultTargetPlatform == TargetPlatform.iOS) {
                              DateTime selectedDate = await SalesController
                                  .instance
                                  .pickiOSDate(context, screenSize);
                              // ignore: unnecessary_null_comparison
                              if (selectedDate != null) {
                                ReportsController.instance.todayReport.value =
                                    DateFormat('d MMM').format(selectedDate);
                              } else {
                                ReportsController.instance.todayReport.value =
                                    DateFormat('d MMM').format(DateTime.now());
                              }
                            } else {
                              DateTime selectedDate = await SalesController
                                  .instance
                                  .pickDate(context);
                              // ignore: unnecessary_null_comparison
                              if (selectedDate != null) {
                                ReportsController.instance.todayReport.value =
                                    DateFormat('d MMM').format(selectedDate);
                              } else {
                                ReportsController.instance.todayReport.value =
                                    DateFormat('d MMM').format(DateTime.now());
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: !isDarkMood
                                    ? kTextFieldLightBorderColor
                                    : kTextFieldDarkBorderColor
                                        .withOpacity(0.5),
                              ),
                              Obx(
                                () => Text(
                                  ' $kReportTodayText : ${ReportsController.instance.todayReport.value} ',
                                  style: const TextStyle(
                                    color: kGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                          ),
                          onPressed: () {
                            ReportsController.instance.pickTommorow(
                              context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 4.0,
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: screenSize.width * 0.47,
                          height: screenSize.height * 0.057,
                          decoration:
                              ReportsController.instance.showPOSGrid.value
                                  ? BoxDecoration(
                                      color: ReportsController
                                              .instance.showPOSGrid.value
                                          ? isDarkMood
                                              ? kTextFieldDarkBorderColor
                                              : kLightModeDashboardAppbarColor
                                          : isDarkMood
                                              ? kTransparentColor
                                              : kWhiteLight,
                                    )
                                  : BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3),
                                      ),
                                      border: Border.all(
                                        color: ReportsController.instance
                                                    .showPOSGrid.value ==
                                                false
                                            ? isDarkMood
                                                ? kTextFieldDarkBorderColor
                                                : kLightModeDashboardAppbarColor
                                            : isDarkMood
                                                ? kTransparentColor
                                                : kWhiteLight,
                                      ),
                                    ),
                          child: TextButton(
                            onPressed: () {
                              ReportsController.instance.setPOSGrid();
                            },
                            child: Text(
                              'POS Reports',
                              style: TextStyle(
                                fontSize: 15,
                                color: isDarkMood
                                    ? ReportsController
                                            .instance.showPOSGrid.value
                                        ? kWhiteLight
                                        : kWhiteDark
                                    : ReportsController
                                            .instance.showPOSGrid.value
                                        ? kWhiteLight
                                        : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                          child: Container(
                        width: screenSize.width * 0.47,
                        height: screenSize.height * 0.057,
                        decoration: ReportsController.instance.showPOSGrid.value
                            ? BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(3),
                                  bottomRight: Radius.circular(3),
                                ),
                                border: Border.all(
                                  color: ReportsController
                                          .instance.showPOSGrid.value
                                      ? isDarkMood
                                          ? kTextFieldDarkBorderColor
                                          : kLightModeDashboardAppbarColor
                                      : isDarkMood
                                          ? kTransparentColor
                                          : kWhiteLight,
                                ),
                              )
                            : BoxDecoration(
                                color:
                                    ReportsController.instance.showPOSGrid.value
                                        ? isDarkMood
                                            ? kTransparentColor
                                            : kWhiteLight
                                        : isDarkMood
                                            ? kTextFieldDarkBorderColor
                                            : kLightModeDashboardAppbarColor,
                              ),
                        child: TextButton(
                          onPressed: () {
                            ReportsController.instance.setStoreFrontGrid();
                            // setState(() {
                            //   _showGrid = false;
                            // });
                            print('showPOSGrid == false');
                          },
                          child: Text(
                            'Storefront Reports',
                            style: TextStyle(
                              fontSize: 15,
                              color: isDarkMood
                                  ? ReportsController.instance.showPOSGrid.value
                                      ? kWhiteDark
                                      : kWhiteLight
                                  : ReportsController.instance.showPOSGrid.value
                                      ? kBlack
                                      : kWhiteLight,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                )),
            Obx(() {
              return ReportsController.instance.showPOSGrid.value
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          height: screenSize.height,
                          width: screenSize.height * 0.5,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(
                              11,
                              (index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: !isDarkMood
                                        ? kLightModeActiveButtonColor
                                        : kDarkComplementColor
                                            .withOpacity(0.25),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 1:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 2:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;
                                            case 3:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;
                                            case 4:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 5:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 6:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 7:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 8:
                                              Get.to(
                                                () => const TopCustomerReport(),
                                              );
                                              break;
                                            case 9:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;

                                            case 10:
                                              Get.to(
                                                () => const TopCustomerReport(),
                                              );
                                              break;
                                            default:
                                              break;
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                ReportsController.instance
                                                    .posReport[index]['title']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color:
                                                      kTextFieldDarkBorderColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                ReportsController.instance
                                                    .posReport[index]['detail']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: kWhiteLight,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                ReportsController.instance
                                                    .posReport[index]['value']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: kWhiteLight,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          height: screenSize.height,
                          width: screenSize.height * 0.5,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(
                              11,
                              (index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: !isDarkMood
                                        ? kLightModeActiveButtonColor
                                        : kDarkComplementColor
                                            .withOpacity(0.25),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 1:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 2:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;
                                            case 3:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;
                                            case 4:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 5:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 6:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 7:
                                              Get.to(
                                                () => const SalesReport(),
                                              );
                                              break;
                                            case 8:
                                              Get.to(
                                                () => const TopCustomerReport(),
                                              );
                                              break;
                                            case 9:
                                              Get.to(
                                                () => const CategoryReport(),
                                              );
                                              break;

                                            case 10:
                                              Get.to(
                                                () => const TopCustomerReport(),
                                              );
                                              break;
                                            default:
                                              break;
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              ReportsController
                                                  .instance
                                                  .storeFrontReport[index]
                                                      ['title']
                                                  .toString(),
                                              style: const TextStyle(
                                                color:
                                                    kTextFieldDarkBorderColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                ReportsController
                                                    .instance
                                                    .storeFrontReport[index]
                                                        ['detail']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: kWhiteLight,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                ReportsController
                                                    .instance
                                                    .storeFrontReport[index]
                                                        ['value']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: kWhiteLight,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
