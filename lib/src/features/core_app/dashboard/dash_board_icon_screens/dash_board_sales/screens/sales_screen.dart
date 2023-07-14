import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/payment_summary.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/pending_payment.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesState();
}

class _SalesState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;
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
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kMainColorLight),
                  ),
                  // color: kMainColorLight,
                  child: Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: kBlackDark,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100));
                            // print();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: kMainColorLight,
                              ),
                              Text(
                                'Today : 24 Jan ',
                                style: TextStyle(
                                  color: kGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: kBlackDark,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
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
