import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../localizations/currency.dart';
import '../application/reciepts_controller.dart';

class ReceiptView extends StatelessWidget {
  final ReceiptsModel receipt;

  const ReceiptView({Key? key, required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    print(ReceiptsController.instance.receiptNo.value);

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: truncateString(receipt.receiptNo, 20),
          automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nairaFormat.format(
                                    double.parse(
                                      receipt.cartTotal,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 27),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  formatDateTime(
                                    receipt.date.toString(),
                                  ),
                                  style: const TextStyle(
                                    color: kGreyColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: !isDarkMood
                                      ? kTextFieldLightBorderColor
                                          .withOpacity(0.1)
                                      : kTextFieldDarkBorderColor
                                          .withOpacity(0.1),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: IconButton(
                                  onPressed: () {
                                    // print(receipt.date.toString());
                                  },
                                  icon: Icon(
                                    Icons.ios_share,
                                    size: 25,
                                    color: !isDarkMood
                                        ? kMainComplimemtColorLight
                                        : kWhiteLight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Staff - Attendant'),
                            Text('Staff - ${receipt.attendant}'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Details",
                          style: TextStyle(fontSize: 27),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.6,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => const ListTile(
                              title: Text('item Name'),
                              subtitle: Text('item quantity x item price'),
                              trailing: Text('Total price'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            top: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Total'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                nairaFormat.format(
                                  double.parse(
                                    receipt.cartTotal,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
