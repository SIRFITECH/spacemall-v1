import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class ShopfrontReport extends StatefulWidget {
  const ShopfrontReport({super.key});
  static String id = 'store_front_report_screen';

  @override
  State<ShopfrontReport> createState() => _StorefrontReportState();
}

late List<HourlySalesData> hourlyChartData;
// late List<WeeklySalesData> _weeklyChartData;
late List<MonthlySalesData> _monthlyChartData;
bool _showGrid = true;
int selected = 0;

Map<String, double> dataMap = {
  "Debit Card": 55,
  "2Settle": 38,
  "Cash": 25,
  "Transfer": 15,
};

class _StorefrontReportState extends State<ShopfrontReport> {
  // @override
  // void initState() {
  //   hourlyChartData = getHourlyChartData();
  //   // _weeklyChartData = getWeeklyChartData();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;
    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kReportShopfrontText,
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
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text('Toggle')],
              ),
            ),
            _showGrid
                ? Center(
                    child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: PieChart(
                          chartRadius: MediaQuery.of(context).size.height * 0.3,
                          dataMap: dataMap,
                          legendOptions: const LegendOptions(
                            showLegends: true,
                            // showLegendsInRow: true,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesOutside: true),
                        ),
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
