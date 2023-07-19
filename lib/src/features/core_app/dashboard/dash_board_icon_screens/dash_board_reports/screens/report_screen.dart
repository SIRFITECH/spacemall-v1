import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_report.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

bool _showGrid = true;

const List posReport = [
  {
    "title": "TOTAL SALE",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "PROFITS",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "TOP STOCK",
    "detail": "",
    "value": "TOP STOCK: 25",
  },
  {
    "title": "TOP CARTEGORY",
    "detail": "",
    "value": "DRINKS: 55",
  },
  {
    "title": "SALES",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "TAX",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "DISCOUNT",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "AVERAGE SALES VALUE",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "TOP CUSTOMER",
    "detail": "OSAGIE DAVID",
    "value": "osagiedavid@gmail.com",
  },
  {
    "title": "PAYMENT MODES",
    "detail": "CASH",
    "value": "N 100,000.00",
  },
  {
    "title": "SOLD BY",
    "detail": "OSAGIE DAVID",
    "value": "osagiedavid@gmail.com"
  },
];

const List storeFrontReport = [
  {
    "title": "TOTAL SALE",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "PROFITS",
    "detail": "",
    "value": "N 150,000.00",
  },
  {
    "title": "TOP STOCK",
    "detail": "",
    "value": "TOP STOCK: 60",
  },
  {
    "title": "TOP CARTEGORY",
    "detail": "",
    "value": "DRINKS: 55",
  },
  {
    "title": "SALES",
    "detail": "",
    "value": "N 150,000.00",
  },
  {
    "title": "TAX",
    "detail": "",
    "value": "N 20,000.00",
  },
  {
    "title": "DISCOUNT",
    "detail": "",
    "value": "N 00.00",
  },
  {
    "title": "AVERAGE SALES VALUE",
    "detail": "",
    "value": "N 100,000.00",
  },
  {
    "title": "TOP CUSTOMER",
    "detail": "OSAGIE DAVID",
    "value": "osagiedavid@gmail.com",
  },
  {
    "title": "PAYMENT MODES",
    "detail": "CASH",
    "value": "N 100,000.00",
  },
  {
    "title": "SOLD BY",
    "detail": "OLUWAFEMI ADEYEMI",
    "value": "femiadeyemi@gmail.com"
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

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: kReportAppBarText,
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
                    () => const TopCustomerReport(),
                    // CategoryReport(),
                    // SalesReport(),
                    // ShopfrontReport(),
                    // RemainingStock(),
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
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
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
                    width: MediaQuery.of(context).size.width * 0.47,
                    color: _showGrid ? kMainColorLight : kGreyColor,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showGrid = true;
                        });
                      },
                      child: const Text(
                        'POS Reports',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    color: _showGrid ? kGreyColor : kMainColorLight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showGrid = false;
                        });
                      },
                      child: const Text(
                        'Storefront Reports',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            _showGrid
                ? Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.height * 0.5,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                          11,
                          (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: kMainColorLight,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          posReport[index]['title'].toString(),
                                          style: const TextStyle(
                                            color: kMainColorLight,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          posReport[index]['detail'].toString(),
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
                                          posReport[index]['value'].toString(),
                                          style: const TextStyle(
                                              color: kWhiteLight),
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
                  )
                : Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.height * 0.5,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                          11,
                          (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: kMainColorLight,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        storeFrontReport[index]['title']
                                            .toString(),
                                        style: const TextStyle(
                                            color: kMainColorLight),
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
          ],
        ),
      ),
    );
  }
}
