import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _ReportSalesState();
}

late List<HourlySalesData> _hourlyChartData;
// late List<WeeklySalesData> _weeklyChartData;
late List<MonthlySalesData> _monthlyChartData;
bool _showGrid = true;
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
    // _weeklyChartData = getWeeklyChartData();
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
        title: '${store.storeName} $kReportByTimeText',
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMood
              ? kDarkModeBackgroundColor.withAlpha(2)
              : kWhiteLight.withAlpha(2),
          image: const DecorationImage(
            image: AssetImage(kBackGroundCart),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    width: screenSize.width * 0.313,
                    height: screenSize.height * 0.062,
                    color: _showGrid ? kMainColorLight : kGreyColor,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showGrid = true;
                          _selected = 0;
                        });
                      },
                      child: const Text(
                        'HOUR',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width * 0.313,
                    height: MediaQuery.of(context).size.height * 0.062,
                    color: _showGrid ? kGreyColor : kMainColorLight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showGrid = false;
                          _selected = 1;
                        });
                      },
                      child: const Text(
                        'WEEK',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width * 0.313,
                    height: MediaQuery.of(context).size.height * 0.062,
                    color: _showGrid ? kGreyColor : kMainColorLight,
                    child: TextButton(
                      onPressed: () {
                        // print(reportValues[1]['title']);
                        setState(() {
                          _showGrid = false;
                          _selected = 2;
                        });
                      },
                      child: const Text(
                        'MONTH',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            _showGrid
                ? Center(
                    child: Column(
                    children: [
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // primaryYAxis: NumericAxis(),
                        series: [
                          ColumnSeries(
                            color: kMainColorLight,
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
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
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
                                      width: 1, color: kMainColorLight),
                                ),
                                child: const ListTile(
                                  title: Text('Start'),
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
                                      width: 1, color: kMainColorLight),
                                ),
                                child: const ListTile(
                                  title: Text('Mid 1'),
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
                                      width: 1, color: kMainColorLight),
                                ),
                                child: const ListTile(
                                  title: Text('Mid 2'),
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
                                      width: 1, color: kMainColorLight),
                                ),
                                child: const ListTile(
                                  title: Text('End'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),

                      // const ListTile(
                      //   title: Text('Start'),
                      // ),
                      // const ListTile(
                      //   title: Text('Mid 1'),
                      // ),
                      // const ListTile(
                      //   title: Text('Mid 2'),
                      // ),
                      // const ListTile(
                      //   title: Text('End'),
                      // ),
                    ],
                  ))

                // :
                // Center(
                //     child: Column(
                //     children: [
                //       SfCartesianChart(
                //         primaryXAxis: CategoryAxis(),
                //         // primaryYAxis: NumericAxis(),
                //         series: [
                //           ColumnSeries(
                //             color: kMainColorLight,
                //             dataSource: _weeklyChartData,
                //             yValueMapper: (WeeklySalesData sales, _) =>
                //                 sales.sales,
                //             xValueMapper: (WeeklySalesData sales, _) =>
                //                 sales.days,
                //           )
                //         ],
                //       ),
                //       Container(
                //         height: MediaQuery.of(context).size.height * 0.5,
                //         child: ListView(
                //           children: const [
                //             ListTile(
                //               title: Text('Start Week'),
                //             ),
                //             ListTile(
                //               title: Text('Mid 1 Week'),
                //             ),
                //             ListTile(
                //               title: Text('Mid 2 Week'),
                //             ),
                //             ListTile(
                //               title: Text('Mid 2 Week'),
                //             ),
                //             ListTile(
                //               title: Text('Mid 2 Week'),
                //             ),
                //             ListTile(
                //               title: Text('End Week'),
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ))

                : Center(
                    child: Column(
                    children: [
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // primaryYAxis: NumericAxis(),
                        series: [
                          ColumnSeries(
                            color: kMainColorLight,
                            dataSource: _monthlyChartData,
                            yValueMapper: (MonthlySalesData sales, _) =>
                                sales.sales,
                            xValueMapper: (MonthlySalesData sales, _) =>
                                sales.days,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView(
                          children: const [
                            ListTile(
                              title: Text('Jannuary'),
                            ),
                            ListTile(
                              title: Text('Ferbruary'),
                            ),
                            ListTile(
                              title: Text('March'),
                            ),
                            ListTile(
                              title: Text('April'),
                            ),
                            ListTile(
                              title: Text('May'),
                            ),
                            ListTile(
                              title: Text('June'),
                            ),
                            ListTile(
                              title: Text('July'),
                            ),
                            ListTile(
                              title: Text('August'),
                            ),
                            ListTile(
                              title: Text('September'),
                            ),
                            ListTile(
                              title: Text('October'),
                            ),
                            ListTile(
                              title: Text('November'),
                            ),
                            ListTile(
                              title: Text('December'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
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

  // List<WeeklySalesData> getWeeklyChartData() {
  //   final List<WeeklySalesData> chartData = [
  //     WeeklySalesData(125000, 'Mon'),
  //     WeeklySalesData(62500, 'Wed'),
  //     WeeklySalesData(62500, 'Wed'),
  //     WeeklySalesData(30000, 'Thur'),
  //     WeeklySalesData(500000, 'Fri'),
  //     WeeklySalesData(250000, 'Sat'),
  //     WeeklySalesData(125000, 'Sun'),
  //   ];
  //   return chartData;
  // }

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

// class WeeklySalesData {
//   WeeklySalesData(this.sales, this.days);
//   final int sales;
//   final String days;
// }

class MonthlySalesData {
  MonthlySalesData(this.sales, this.days);
  final int sales;
  final String days;
}
