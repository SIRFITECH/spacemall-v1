import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';

import '../application/dash_baord_controller.dart';

class DashBoardSalesSummary extends StatelessWidget {
  const DashBoardSalesSummary({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    // String todaySale =
    //     SalesController.instance.getTotalSalesForToday(DateTime.now());

    DashBoardController.instance.todaySales.value = DateFormat('d MMM').format(
      DateTime.now(),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.25,
        horizontal: screenSize.width * 0.2,
      ),
      child: Positioned(
        top: 2,
        child: Container(
          height: screenSize.height * 0.085,
          width: screenSize.width * 0.8,
          decoration: BoxDecoration(
            color: isDarkMood ? kLightThemeBgColor : kLightThemeBgColor,
            border: Border.all(
              width: 2,
              color: isDarkMood ? kDarkModeIconColor : kMainColorLight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                  color: kBlackDark, offset: Offset(2.0, 2.0), blurRadius: 3.0)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.013),
                child: GestureDetector(
                  onTap: () async {
                    if (defaultTargetPlatform == TargetPlatform.iOS) {
                      // SalesController.instance.pickiOSDate(context, screenSize);
                      DateTime selectedDate = await SalesController.instance
                          .pickiOSDate(context, screenSize);
                      // ignore: unnecessary_null_comparison
                      if (selectedDate != null) {
                        DashBoardController.instance.todaySales.value =
                            DateFormat('dd-MM-yyyy').format(selectedDate);
                      } else {
                        DashBoardController.instance.todaySales.value =
                            DateFormat('dd-MM-yyyy').format(DateTime.now());
                      }
                    } else {
                      DateTime selectedDate =
                          await SalesController.instance.pickDate(
                        context,
                      );
                      // ignore: unnecessary_null_comparison
                      if (selectedDate != null) {
                        DashBoardController.instance.todaySales.value =
                            DateFormat('dd-MM-yyyy').format(selectedDate);
                      } else {
                        DashBoardController.instance.todaySales.value =
                            DateFormat('dd-MM-yyyy').format(DateTime.now());
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Iconz(
                      image: kCalenderIcon,
                      color: isDarkMood ? kDarkModeIconColor : kMainColorLight,
                      height: 40,
                      isDarkMood: isDarkMood,
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: kBlackDark,
              ),
              // Obx(
              //   () =>
              GestureDetector(
                onTap: () {
                  print(DashBoardController.instance.todaySales.value);
                  // if (todaySale != '') {
                  //   print(todaySale);
                  // } else {
                  //   print('No sales');
                  // }
                },
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'N ${SalesController.instance.getTotalSalesForToday(DateTime.now())}',
                          // kTodaySalesValueText',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          kTodaySalesText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: kBlackDark,
                    ),
                  ],
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
