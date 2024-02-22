import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../generic_dash_board_screens/linear_bar_indicator_widget.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _ReportSalesState();
}

late List<HourlySalesData> _hourlyChartData;

late List<WeeklySalesData> _weeklyChartData;

late List<MonthlySalesData> _monthlyChartData;
bool showGrid = true;
int _selected = 0;
const List reportValues = [
  {
    "title": "TOTAL SALE",
    "value": "N 100,000.00",
  },
  {
    "title": "PROFITS",
    "value": "N 100,000.00",
  },
  {
    "title": "TOP STOCK",
    "value": "TOP STOCK: 25",
  },
  {
    "title": "TOP CARTEGORY",
    "value": "DRINKS: 55",
  },
  {
    "titile": "SALES",
    "value": "N 100,000.00",
  },
  {
    "title": "TAX",
    "value": "N 100,000.00",
  },
  {
    "title": "DISCOUNT",
    "value": "N 100,000.00",
  },
  {
    "title": "AVERAGE SALES VALUE",
    "value": "N 100,000.00",
  },
  {
    "title": "TOP CUSTOMER",
    "value": [
      "OSAGIE DAVID",
      "osagiedavid@gmail.com",
    ]
  },
  {
    "title": "PAYMENT MODES",
    "value": [
      "CASH",
      "N 100,000.00",
    ]
  },
  {
    "title": "SOLD BY",
    "value": ["OSAGIE DAVID", "osagiedavid@gmail.com"]
  },
];

class _ReportSalesState extends State<SalesReport> {
  @override
  void initState() {
    _hourlyChartData = getHourlyChartData();
    _weeklyChartData = getWeeklyChartData();
    _monthlyChartData = getMonthlyChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
          logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
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
        title: '${store.storeName} $kReportByTimeText',
        automaticallyImplyLeading: false,
      ),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        color: _selected == 0
                            ? isDarkMood
                                ? kTextFieldDarkBorderColor
                                : kLightModeDashboardAppbarColor
                            : isDarkMood
                                ? kWhiteLight
                                : kWhiteLight,
                      ),
                      width: screenSize.width * 0.313,
                      height: screenSize.height * 0.062,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showGrid = true;
                            _selected = 0;
                          });
                        },
                        child: Text(
                          'HOUR',
                          style: TextStyle(
                            fontSize: 15,
                            color: _selected == 0
                                ? isDarkMood
                                    ? kWhiteLight
                                    : kWhiteLight
                                : isDarkMood
                                    ? kTextFieldDarkBorderColor
                                    : kMainColorDark,
                          ),
                        ),
                      ),
                    )),
                    Center(
                        child: Container(
                      color: _selected == 1
                          ? isDarkMood
                              ? kTextFieldDarkBorderColor
                              : kLightModeDashboardAppbarColor
                          : isDarkMood
                              ? kWhiteLight
                              : kWhiteLight,
                      width: screenSize.width * 0.313,
                      height: screenSize.height * 0.062,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showGrid = false;
                            _selected = 1;
                          });
                        },
                        child: Text(
                          'WEEK',
                          style: TextStyle(
                            fontSize: 15,
                            color: _selected == 1
                                ? isDarkMood
                                    ? kWhiteLight
                                    : kWhiteLight
                                : isDarkMood
                                    ? kTextFieldDarkBorderColor
                                    : kMainColorDark,
                          ),
                        ),
                      ),
                    )),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: _selected == 2
                            ? isDarkMood
                                ? kTextFieldDarkBorderColor
                                : kLightModeDashboardAppbarColor
                            : isDarkMood
                                ? kWhiteLight
                                : kWhiteLight,
                      ),
                      width: screenSize.width * 0.313,
                      height: screenSize.height * 0.062,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showGrid = false;
                            _selected = 2;
                          });
                        },
                        child: Text(
                          'MONTH',
                          style: TextStyle(
                            fontSize: 15,
                            color: _selected == 2
                                ? isDarkMood
                                    ? kWhiteLight
                                    : kWhiteLight
                                : isDarkMood
                                    ? kTextFieldDarkBorderColor
                                    : kMainColorDark,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: _selected == 0,
                child: Center(
                    child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: [
                        ColumnSeries(
                          color: isDarkMood
                              ? kTextFieldDarkBorderColor
                              : kMainColorLight,
                          dataSource: _hourlyChartData,
                          yValueMapper: (HourlySalesData sales, _) =>
                              sales.sales,
                          xValueMapper: (HourlySalesData sales, _) =>
                              sales.time,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        screenSize.height * 0.01,
                      ),
                      height: screenSize.height * 0.45,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '6hrs',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('60%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.60,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '12hrs',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('95%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.95,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '18hrs',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('35%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '24hrs',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('15%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
            Visibility(
                visible: _selected == 1,
                child: Center(
                    child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: [
                        ColumnSeries(
                          color: isDarkMood
                              ? kTextFieldDarkBorderColor
                              : kMainColorLight,
                          dataSource: _weeklyChartData,
                          yValueMapper: (WeeklySalesData sales, _) =>
                              sales.sales,
                          xValueMapper: (WeeklySalesData sales, _) =>
                              sales.days,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        screenSize.height * 0.01,
                      ),
                      height: screenSize.height * 0.45,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Monday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('20%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tuesday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('10%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Wednesday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('5%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Thursday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('3%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.03,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Friday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('90%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.90,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Saturday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('50%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.50,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sunday',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('45%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.45,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ))),
            Visibility(
                visible: _selected == 2,
                child: Center(
                    child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: [
                        ColumnSeries(
                          color: isDarkMood
                              ? kTextFieldDarkBorderColor
                              : kMainColorLight,
                          dataSource: _monthlyChartData,
                          yValueMapper: (MonthlySalesData sales, _) =>
                              sales.sales,
                          xValueMapper: (MonthlySalesData sales, _) =>
                              sales.days,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        screenSize.height * 0.01,
                      ),
                      height: screenSize.height * 0.45,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Jan',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('30%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.30,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Feb',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('40%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.40,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Mar',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('20%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Apr',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('80%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.80,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'May',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('60%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.60,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Jun',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('38%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.38,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Jul',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('32%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.32,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Aug',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('50%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sep',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('25%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.25,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Oct',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('53%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.53,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nov',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('40%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.4,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const TopCustomerReportDetails(),
                              //     ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isDarkMood
                                      ? kTextFieldDarkBorderColor
                                      : kMainColorLight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Dec',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('75%'
                                            // '${percent.toInt().toString()}%',
                                            ),
                                        Text('N 20,000'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: screenSize.width,
                                      child: LinearBarIndicator(
                                        isDarkMood: isDarkMood,
                                        percentage: 0.75,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                )))
          ],
        ),
      ),
    );
  }

  List<HourlySalesData> getHourlyChartData() {
    final List<HourlySalesData> hourlyChartData = [
      HourlySalesData(60, '6hrs'),
      HourlySalesData(95, '12hrs'),
      HourlySalesData(45, '18hrs'),
      HourlySalesData(10, '24hrs'),
    ];
    return hourlyChartData;
  }

  List<WeeklySalesData> getWeeklyChartData() {
    final List<WeeklySalesData> chartData = [
      WeeklySalesData(125000, 'Mon'),
      WeeklySalesData(65500, 'Tue'),
      WeeklySalesData(62500, 'Wed'),
      WeeklySalesData(30000, 'Thur'),
      WeeklySalesData(500000, 'Fri'),
      WeeklySalesData(250000, 'Sat'),
      WeeklySalesData(125000, 'Sun'),
    ];
    return chartData;
  }

  List<MonthlySalesData> getMonthlyChartData() {
    final List<MonthlySalesData> chartData = [
      MonthlySalesData(37000, 'Jan'),
      MonthlySalesData(62500, 'Feb'),
      MonthlySalesData(5000, 'Mar'),
      MonthlySalesData(100000, 'Apr'),
      MonthlySalesData(80000, 'May'),
      MonthlySalesData(60000, 'Jun'),
      MonthlySalesData(45000, 'Jul'),
      MonthlySalesData(75000, 'Aug'),
      MonthlySalesData(30000, 'Sep'),
      MonthlySalesData(80000, 'Oct'),
      MonthlySalesData(50000, 'Nov'),
      MonthlySalesData(90000, 'Dec'),
    ];
    return chartData;
  }
}

class HourlySalesData {
  HourlySalesData(this.sales, this.time);
  final int sales;
  final String time;
}

class WeeklySalesData {
  WeeklySalesData(this.sales, this.days);
  final int sales;
  final String days;
}

class MonthlySalesData {
  MonthlySalesData(this.sales, this.days);
  final int sales;
  final String days;
}
