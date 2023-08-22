import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../generic_dash_board_screens/linear_bar_indicator_widget.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class CategoryReport extends StatefulWidget {
  const CategoryReport({super.key});

  @override
  State<CategoryReport> createState() => _CategoryReportState();
}

// late List<HourlySalesData> _hourlyChartData;

late List<MonthlySalesData> _monthlyChartData;
bool _showGrid = true;

Map<String, double> dataMap = {
  "Snacks": 55,
  "Cloths": 38,
  "Phone": 25,
  "Drink": 15,
};

class _CategoryReportState extends State<CategoryReport> {
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
        title: ' ${store.storeName} $kReportCategoryReportText',
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
                          chartType: ChartType.ring,
                          // chartType: ChartType.disc,
                          ringStrokeWidth: 50,
                          chartRadius: screenSize.height * 0.2,
                          // chartRadius: screenSize.height * 0.3,
                          dataMap: dataMap,
                          legendOptions: const LegendOptions(
                            showLegends: true,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValues: true,
                            showChartValuesOutside: false,
                            showChartValuesInPercentage: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        height: screenSize.height * 0.5,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Snacks',
                                        style: TextStyle(
                                          color: kGreyColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '35 orders',
                                            style: TextStyle(
                                              color: kGreyColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('55%'),
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
                                          percentage: 0.55,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Cloths',
                                        style: TextStyle(
                                          color: kGreyColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '35 orders',
                                            style: TextStyle(
                                              color: kGreyColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('15%'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Phone',
                                        style: TextStyle(
                                          color: kGreyColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '35 orders',
                                            style: TextStyle(
                                              color: kGreyColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('25%'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Drink',
                                        style: TextStyle(
                                          color: kGreyColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '35 orders',
                                            style: TextStyle(
                                              color: kGreyColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('38%'),
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
                          ],
                        ),
                      ),
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
                            color: kWhiteLight,
                            dataSource: _monthlyChartData,
                            yValueMapper: (MonthlySalesData sales, _) =>
                                sales.sales,
                            xValueMapper: (MonthlySalesData sales, _) =>
                                sales.days,
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.5,
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
