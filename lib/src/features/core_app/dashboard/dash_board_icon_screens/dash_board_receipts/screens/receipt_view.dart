import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../localizations/currency.dart';

class ReceiptView extends StatelessWidget {
  final ReceiptsModel receipt;

  const ReceiptView({Key? key, required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: truncateString(receipt.receiptId, 15),
          automaticallyImplyLeading: false),
      body: SizedBox(
        height: screenSize.height * 0.07,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.07,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  side: BorderSide(
                    color: !isDarkMood
                        ? kTextFieldLightBorderColor.withOpacity(0.5)
                        : kTextFieldDarkBorderColor.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receipt.customerName,
                          ),
                          // Obx(
                          //   () =>
                          Row(
                            children: [
                              Text(
                                receipt.itemsInCart,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('d MMM, yyyy').format(
                                  receipt.date,
                                ),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          // ),
                        ],
                      ),
                      // Obx(
                      //   () =>
                      Text(
                        nairaFormat.format(
                          double.parse(
                            receipt.cartTotal,
                          ),
                        ),
                        style: const TextStyle(fontSize: 12),
                      ),

                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
