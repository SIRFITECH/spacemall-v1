import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/pay_later.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/localizations/currency.dart';

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
                  color: isDarkMood
                      ? kDarkModeBackgroundColor.withOpacity(0.1)
                      : kLightModeBackgroundColor.withOpacity(0.1),
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
                                GestureDetector(
                                  onTap: () {
                                    print(checkOutItemController
                                        .cartItems[index].quantityInCart);
                                    num quantity = int.parse(
                                            checkOutItemController
                                                .cartItems[index]
                                                .quantityInCart) +
                                        1;
                                    checkOutItemController.cartItems[index]
                                        .quantityInCart = quantity.toString();
                                    String priceString = checkOutItemController
                                        .cartItems[index].price;
                                    String numPriceString = priceString
                                        .replaceAll(RegExp(r'[^0-9]'), '');
                                    String quantityInCartString =
                                        checkOutItemController
                                            .cartItems[index].quantityInCart;
                                    String numQuantityInCartString =
                                        quantityInCartString.replaceAll(
                                            RegExp(r'[^0-9]'), '');
                                    num initCost =
                                        int.parse(numQuantityInCartString) *
                                            int.parse(numPriceString);
                                    num cost = initCost;

                                    checkOutItemController.cartItems[index]
                                        .subTotal = cost.toString();
                                    print(checkOutItemController
                                        .cartItems[index].subTotal);
                                    print('${stockItem.itemId} taped');
                                  },
                                  onLongPress: () {
                                    checkOutItemController
                                        .removeItemFromCart(index);
                                    Get.snackbar(
                                      '${stockItem.itemName}  Deleted ',
                                      '${stockItem.itemName} deleted successfully from cart',
                                      backgroundColor: kWhiteLight,
                                    );
                                  },
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
                                                  stockItem.itemName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                                Text(
                                                  '${stockItem.quantityInCart} x ${stockItem.price}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              nairaFormat.format(
                                                int.parse(stockItem.subTotal),
                                              ),
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
                  color: isDarkMood
                      ? kDarkModeIconColor
                      : kLightModeBackgroundColor,
                  height: screenSize.height * 0.215,
                  // 181,
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: isDarkMood
                            ? kDarkModeIconColor
                            : kLightModeBackgroundColor,
                        child: const Padding(
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
                      Card(
                        elevation: 0,
                        color: isDarkMood
                            ? kDarkModeIconColor
                            : kLightModeBackgroundColor,
                        child: const Padding(
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
                      Card(
                        elevation: 0,
                        color: isDarkMood
                            ? kDarkModeIconColor
                            : kLightModeBackgroundColor,
                        child: const Padding(
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
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const ChooseUserType());
                },
                child: const Text(
                  kConfirmPaymentText,
                  style: TextStyle(fontSize: 15, color: kWhiteLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
