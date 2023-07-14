import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_details.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';

class TopCustomerReport extends StatefulWidget {
  const TopCustomerReport({super.key});
  static String id = 'top_customer_report_screen';

  @override
  State<TopCustomerReport> createState() => _TopCustomerReportState();
}

class _TopCustomerReportState extends State<TopCustomerReport> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kReportCustomerReportText,
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
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const TopCustomerReportDetails(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kMainColorLight),
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
                  Get.to(
                    () => const TopCustomerReportDetails(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kMainColorLight),
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
                  Get.to(
                    () => const TopCustomerReportDetails(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kMainColorLight),
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
                  Get.to(
                    () => const TopCustomerReportDetails(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kMainColorLight),
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
      ),
    );
  }
}
