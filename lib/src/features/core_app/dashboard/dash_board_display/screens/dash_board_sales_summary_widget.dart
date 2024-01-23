import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

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

    DashBoardController.instance.todaySales.value = DateFormat('d MMM').format(
      DateTime.now(),
    );

    return Positioned(
      top: screenSize.height * 0.25,
      left: screenSize.width * 0.2,
      child: Container(
        height: screenSize.height * 0.085,
        width: screenSize.width * 0.6,
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
                    DateTime selectedDate = await SalesController.instance
                        .pickiOSDate(context, 
                        // screenSize
                        );
                    // ignore: unnecessary_null_comparison
                    if (selectedDate != null) {
                      DashBoardController.instance.todaySales.value =
                          DateFormat('dd-MM-yyyy').format(selectedDate);
                      DashBoardController.instance.selectedDate = selectedDate;
                    } else {
                      DashBoardController.instance.todaySales.value =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                      DashBoardController.instance.selectedDate = selectedDate;
                    }

                    SalesController.instance.getTotalSalesForToday(
                        DashBoardController.instance.selectedDate =
                            selectedDate);
                  } else {
                    DateTime selectedDate =
                        await SalesController.instance.pickDate(
                      context,
                    );
                    // ignore: unnecessary_null_comparison
                    if (selectedDate != null) {
                      DashBoardController.instance.todaySales.value =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      DashBoardController.instance.selectedDate = selectedDate;
                    } else {
                      DashBoardController.instance.todaySales.value =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      DashBoardController.instance.selectedDate = selectedDate;
                    }
                    SalesController.instance.getTotalSalesForToday(
                      DateTime.parse(
                          DashBoardController.instance.todaySales.value),
                    );
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
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<SalesController>(
                        id: 'sales-summary',
                        builder: (salesController) => Text(
                          truncateString(
                              nairaFormat.format(
                                double.parse(
                                  SalesController.instance
                                      .getTotalSalesForToday(DashBoardController
                                          .instance.selectedDate)
                                      .toString(),
                                ),
                              ),
                              13),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      GetBuilder<DashBoardController>(
                          builder: (dashBoardController) =>
                              // DashBoardController.instance.todaySales.value ==
                              //         DateFormat('d MMM').format(
                              //           DateTime.now(),
                              //         )
                              //     ?
                              Text(
                                kTodaySalesText,
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                          // : RichText(
                          //     text: TextSpan(
                          //       children: [
                          //         TextSpan(
                          //           text: 'Sales for  ',
                          //           style: TextStyle(
                          //             color: isDarkMood
                          //                 ? kWhiteLight
                          //                 : kBlackDark,
                          //           ),
                          //         ),
                          //         TextSpan(
                          //           text: DashBoardController
                          //               .instance.todaySales.value,
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             color: isDarkMood
                          //                 ? kWhiteLight
                          //                 : kBlackDark,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
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
          ],
        ),
      ),
    );
  }
}
