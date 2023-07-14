import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_settings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../general/custom_divider.dart';

class ReceiptListScreen extends StatefulWidget {
  const ReceiptListScreen({super.key});

  @override
  State<ReceiptListScreen> createState() => _ReceiptListState();
}

class _ReceiptListState extends State<ReceiptListScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final ReceiptsController receiptController = ReceiptsController();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kReceiptsAppBarText,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    width: screenSize.width * 0.47,
                    color: kMainColorLight,
                    child: TextButton(
                      onPressed: () {
                        print(receiptController.receipts.length);
                        print('Change screen backwatd');
                      },
                      child: const Text(
                        '17-01-2023',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    color: kGreyColor,
                    child: TextButton(
                      onPressed: () {
                        print('Change screen farwardwatd');
                      },
                      child: const Text(
                        '20-01-2023',
                        style: TextStyle(fontSize: 15, color: kWhiteLight),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: kTransparentColor,
                    height: screenSize.height * 0.6,
                    child: ListView.builder(
                      itemCount: receiptController.receipts.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: screenSize.height * 0.1,
                          child: Column(
                            children: [
                              // if (index <
                              //     checkOutItemController.cartItems.length)
                              GestureDetector(
                                // onHorizontalDragStart:
                                //     (DragStartDetails details) {
                                //   checkOutItemController
                                //       .decreaseItemQuantityInCart(index);
                                // },
                                onTap: () {
                                  print('This gives receipt details');
                                },
                                // onLongPress: () {
                                //   checkOutItemController
                                //       .deleteItemFromCart(index);
                                // },
                                child: SizedBox(
                                  width: double.infinity,
                                  height: screenSize.height * 0.1,
                                  child: Card(
                                    color: kTransparentColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // checkOutItemController
                                                //     .cartItems[index]
                                                //     .itemName,
                                                receiptController
                                                    .receipts[index].storeName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              Text(
                                                receiptController
                                                    .receipts[index].receiptNo,
                                                // '${stockList.quantityInCart} x ${stockList.price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            // nairaFormat.format(

                                            //   stockList.subTotal,
                                            // ),
                                            receiptController
                                                .receipts[index].date
                                                .toIso8601String(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomDivider(
                                height: screenSize.height * 0.0002,
                                thickness: screenSize.height * 0.002,
                                color: kWhiteLight,
                                margin: const EdgeInsets.all(0),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                    // ListView(
                    //   children: const [
                    //     Column(
                    //       children: [
                    //         ListTile(
                    //           isThreeLine: true,
                    //           title: Text('5alive(Medium)'),
                    //           subtitle: Text('2 X N1,000'),
                    //           trailing: Text('N 2,000'),
                    //         ),
                    //         Divider(
                    //           color: kWhiteLight,
                    //           height: 2,
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         ListTile(
                    //           title: Text('Coka-Cosla(Medium)'),
                    //           subtitle: Text('1 X N750'),
                    //           trailing: Text('N 750'),
                    //         ),
                    //         Divider(
                    //           color: kWhiteLight,
                    //           height: 2,
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         ListTile(
                    //           title: Text('Hollandia(Medium)'),
                    //           subtitle: Text('2 X N1,500'),
                    //           trailing: Text('N 3,000'),
                    //         ),
                    //         Divider(
                    //           color: kWhiteLight,
                    //           height: 2,
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         ListTile(
                    //           title: Text('Orie Biscuit'),
                    //           subtitle: Text('3 X N1,200'),
                    //           trailing: Text('N 3,600'),
                    //         ),
                    //         Divider(
                    //           color: kWhiteLight,
                    //           height: 2,
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         ListTile(
                    //           title: Text('McDowells'),
                    //           subtitle: Text('2 X N15,000'),
                    //           trailing: Text('N 30,000'),
                    //         ),
                    //         Divider(
                    //           color: kWhiteLight,
                    //           height: 2,
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),

                    ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
              child: SizedBox(
                width: screenSize.width * 0.4,
                // 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => const ReceiptSettings(),
                    );
                  },
                  child: const Text(
                    kReceiptsLoadMoreText,
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
