import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/pay_later_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/confirm_payment.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class PayLater extends StatelessWidget {
  const PayLater({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    // final textTheme = Theme.of(context).textTheme;
    final payLaterController = Get.put(
      PayLaterController(),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const ConfirmPayment());
                },
                child: const Text(kBackText)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8, bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: payLaterController.customerName,
                  keyboardType: TextInputType.name,
                  hintText: '',
                  labelText: kCustomerNameText,
                  maxLines: 1,
                  height: screenSize.height * 0.04,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 2, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: payLaterController.paymentDate,
                  keyboardType: TextInputType.datetime,
                  hintText: 'dd/mm/yyyy',
                  labelText: kPaymentDateText,
                  maxLines: 1,
                  height: screenSize.height * 0.04,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => DashBoard());
              },
              child: const Text(
                kSaveText,
                style: TextStyle(fontSize: 15, color: kWhiteLight),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
