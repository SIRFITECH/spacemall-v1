import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/category_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/remaining_stock_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/sales_report.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_report.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

bool _showGrid = true;

const List posReport = [
  {
    // finance summary - sales report
    "title": "TOTAL SALE",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "PROFITS",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    // finance summary - category
    "title": "TOP STOCK",
    "detail": "TOP STOCK: 25",
    "value": "",
  },
  {
    "title": "TOP CARTEGORY",
    "detail": "DRINKS: 55",
    "value": "",
  },
  {
    "title": "SALES",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "TAX",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "DISCOUNT",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "AVERAGE\n SALES VALUE",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "TOP CUSTOMER",
    "detail": "OSAGIE\n DAVID",
    "value": "osagiedav@gmail.com",
  },
  {
    "title": "PAYMENT MODES",
    "detail": "CASH",
    "value": "N 100,000.00",
  },
  {
    "title": "SOLD BY",
    "detail": "OSAGIE\n DAVID",
    "value": "osagiedav@gmail.com"
  },
];

const List storeFrontReport = [
  {
    "title": "TOTAL SALE",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "PROFITS",
    "detail": "N 150,000.00",
    "value": "",
  },
  {
    "title": "TOP STOCK",
    "detail": "TOP STOCK: 60",
    "value": "",
  },
  {
    "title": "TOP CARTEGORY",
    "detail": "DRINKS: 55",
    "value": "",
  },
  {
    "title": "SALES",
    "detail": "N 150,000.00",
    "value": "",
  },
  {
    "title": "TAX",
    "detail": "N 20,000.00",
    "value": "",
  },
  {
    "title": "DISCOUNT",
    "detail": "N 00.00",
    "value": "",
  },
  {
    "title": "AVERAGE \n SALES VALUE",
    "detail": "N 100,000.00",
    "value": "",
  },
  {
    "title": "TOP CUSTOMER",
    "detail": "OSAGIE\n DAVID",
    "value": "osagiedav@gmail.com",
  },
  {
    "title": "PAYMENT MODES",
    "detail": "CASH",
    "value": "N 100,000.00",
  },
  {
    "title": "SOLD BY",
    "detail": "OLUWAFEMI\n ADEYEMI",
    "value": "femiade@gmail.com"
  },
];

DateTime now = DateTime.now();
String date = DateFormat('d MMM').format(now);
String dateNow = getFormattedDate(now);
String getFormattedDate(DateTime date) {
  int day = date.day;
  String suffix;
  if (day >= 11 && day <= 13) {
    suffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
        break;
    }
  }

  return DateFormat('d $suffix MMM').format(date);
}

class _ReportScreenState extends State<ReportScreen> {
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
                        Icon(
                          Icons.arrow_back,
                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100));
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
                              Text(
                                ' $kReportTodayText : $date ',
                                style: const TextStyle(
                                  color: kGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,

                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                          // kBlackDark,
                        )
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: screenSize.width * 0.47,
                      height: screenSize.height * 0.057,
                      decoration: _showGrid
                          ? BoxDecoration(
                              color: _showGrid
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
                                color: _showGrid == false
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
                          setState(() {
                            _showGrid = true;
                          });
                        },
                        child: Text(
                          'POS Reports',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMood
                                ? _showGrid
                                    ? kWhiteLight
                                    : kWhiteDark
                                : _showGrid
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
                    decoration: _showGrid
                        ? BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(3),
                              bottomRight: Radius.circular(3),
                            ),
                            border: Border.all(
                              color: _showGrid
                                  ? isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kLightModeDashboardAppbarColor
                                  : isDarkMood
                                      ? kTransparentColor
                                      : kWhiteLight,
                            ),
                          )
                        : BoxDecoration(
                            color: _showGrid
                                ? isDarkMood
                                    ? kTransparentColor
                                    : kWhiteLight
                                : isDarkMood
                                    ? kTextFieldDarkBorderColor
                                    : kLightModeDashboardAppbarColor,
                          ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showGrid = false;
                        });
                      },
                      child: Text(
                        'Storefront Reports',
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMood
                              ? _showGrid
                                  ? kWhiteDark
                                  : kWhiteLight
                              : _showGrid
                                  ? kBlack
                                  : kWhiteLight,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            _showGrid
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
                                      : kDarkComplementColor.withOpacity(0.25),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              posReport[index]['title']
                                                  .toString(),
                                              style: const TextStyle(
                                                color:
                                                    kTextFieldDarkBorderColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              posReport[index]['detail']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: kWhiteLight,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              posReport[index]['value']
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
                                      : kDarkComplementColor.withOpacity(0.25),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Storefront Report no $index');
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            storeFrontReport[index]['title']
                                                .toString(),
                                            style: const TextStyle(
                                              color: kTextFieldDarkBorderColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              storeFrontReport[index]['detail']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: kWhiteLight,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              storeFrontReport[index]['value']
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
                  ),
          ],
        ),
      ),
    );
  }
}
