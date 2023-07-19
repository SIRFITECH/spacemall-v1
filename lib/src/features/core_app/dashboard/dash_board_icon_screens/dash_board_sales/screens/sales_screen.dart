import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/payment_summary.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/pending_payment.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    SalesController salesController = Get.put(
      SalesController(),
    );

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kSalesAppBarText,
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
                                ' $kReportTodayText : ${salesController.date.value} ',
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSummary(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: !isDarkMood
                                ? kMainColorLight
                                : kMainComplimemtColorLight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: screenSize.height * 0.06,
                                        width: screenSize.width * 0.12,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: !isDarkMood
                                                ? kMainColorLight
                                                    .withOpacity(0.6)
                                                : kMainComplimemtColorLight
                                                    .withOpacity(
                                                        0.8), // Replace with your desired border color
                                          ),
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      ClipOval(
                                        child: Container(
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.12,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Text(
                                              'N',
                                              style: TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: !isDarkMood
                                                    ? kMainColorLight
                                                        .withOpacity(0.6)
                                                    : kMainComplimemtColorLight
                                                        .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'New Customer',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: !isDarkMood
                                    ? kMainColorLight
                                    : kMainComplimemtColorLight,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSummary(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: kMainColorLight),
                        ),
                        child: const ListTile(
                          leading: Image(
                            height: 35,
                            image: AssetImage(kTrialImage1),
                          ),
                          title: Text('LinkedIn'),
                          subtitle: Text('Paid N 1,000'),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: kMainColorLight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PendingPayment(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: kMainColorLight),
                        ),
                        child: const ListTile(
                          leading: Image(
                            height: 35,
                            image: AssetImage(kTrialImage1),
                          ),
                          title: Text('LinkedIn'),
                          subtitle: Text('Pending N 1,000'),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: kMainColorLight,
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
            ),
          ],
        ),
      ),
    );
  }
}
