import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class TopCustomerReportDetails extends StatefulWidget {
  const TopCustomerReportDetails({super.key});
  static String id = 'top_customer_details_report_screen';

  @override
  State<TopCustomerReportDetails> createState() =>
      _TopCustomerReportDetailsState();
}

class _TopCustomerReportDetailsState extends State<TopCustomerReportDetails> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: kMainColorLight),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Member Since',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kGreyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '01 Jan 2023',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Last Visited',
                                style:
                                    TextStyle(fontSize: 12, color: kBlackDark),
                              ),
                              Text('24 Jan 2023'),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'N100,000.00',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: kBlackDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: kMainColorLight
                      // MediaQuery.of(context).size.height * 0.05,
                      ),
                ),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('More Details'),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 50,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: kMainColorLight
                      // MediaQuery.of(context).size.height * 0.05,
                      ),
                ),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Orders'),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 50,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
