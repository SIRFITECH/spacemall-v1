import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/pay_later.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final CheckOutItemController checkOutItemController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        height: screenSize.height * 0.9,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: kMainComplimemtColorDark,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Obx(() => ListView.builder(
                        itemCount: checkOutItemController.cartItems.length,
                        itemBuilder: (context, index) {
                          var stockItem =
                              checkOutItemController.cartItems[index];

                          return SizedBox(
                            height: screenSize.height * 0.1,
                            child: Column(
                              children: [
                                SizedBox(
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
                                                stockItem.itemName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              Text(
                                                '${stockItem.quantityInCart} x N${stockItem.price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'N${stockItem.totalItemPrice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        ],
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
                      )),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: kMainColorLight,
                  height: 181,
                  child: Column(
                    children: [
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kSubTotalText,
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                // 'N${stockItem!.itemName}',
                                'N 2,000',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kDiscountText,
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'N 0.0',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(kTaxText,
                                  style: TextStyle(
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                'N 200',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(
                        height: screenSize.height * 0.002,
                        thickness: screenSize.height * 0.002,
                        color: kWhiteLight,
                        margin: const EdgeInsets.all(0),
                      ),
                      const ListTile(
                        title: Text(
                          'Total',
                          style: TextStyle(
                            color: kWhiteLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'N 2,000',
                          style: TextStyle(
                              color: kWhiteLight, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                // vertical: 2.0,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PayLater());
                    },
                    child: const Text(kPayLaterText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DashBoard());
                    },
                    child: const Text(kAddItemText),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.height * 0.05),
              child: Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 200,
                  color: kMainColorLight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      kConfirmPaymentText,
                      style: TextStyle(fontSize: 15, color: kWhiteLight),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
