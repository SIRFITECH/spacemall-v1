import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/pay_later.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
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
    checkOutItemController.onInit();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '',
      ),
      drawer: const SpacemallDrawer(),
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
                  child: Obx(() {
                    if (checkOutItemController.isFirstTime.value &&
                        checkOutItemController.cartItems.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.defaultDialog(
                          backgroundColor: !isDarkMood
                              ? kDarkModeBackgroundColor.withOpacity(0.1)
                              : kWhiteDark.withOpacity(0.1),
                          title: kAdjustCartItemText,
                          titleStyle: const TextStyle(
                            color: kWhiteLight,
                          ),
                          content: const Text(
                            kAlertBodyText,
                            style: TextStyle(
                              color: kWhiteLight,
                            ),
                          ),
                          confirm: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(kOkayText),
                          ),
                        );
                      });

                      checkOutItemController.isFirstTime.value = false;
                    }

                    return ListView.builder(
                      itemCount: checkOutItemController.cartItems.length,
                      itemBuilder: (context, index) {
                        var stockItem = checkOutItemController.cartItems[index];

                        return SizedBox(
                          height: screenSize.height * 0.1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onHorizontalDragStart:
                                    (DragStartDetails details) {
                                  checkOutItemController
                                      .decreaseItemQuantityInCart(index);
                                },
                                onTap: () {
                                  checkOutItemController
                                      .increaseItemQuantityInCart(index);

                                  // checkOutItemController.setCartDiscount(0.1);
                                  // checkOutItemController.setCartTax(0.075);
                                },
                                onLongPress: () {
                                  checkOutItemController
                                      .deleteItemFromCart(index);
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
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: isDarkMood
                        ? kDarkModeIconColor
                        : kLightModeBackgroundColor,
                    height: screenSize.height * 0.23,
                    child: Obx(
                      () => Column(
                        children: [
                          Card(
                            elevation: 0,
                            color: isDarkMood
                                ? kDarkModeIconColor
                                : kLightModeBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    kSubTotalText,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kWhiteLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    nairaFormat.format(
                                      checkOutItemController
                                          .totalCartSubTotal.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    kDiscountText,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kWhiteLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    nairaFormat.format(
                                      checkOutItemController
                                          .totalCartDiscount.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(kTaxText,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kWhiteLight,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    nairaFormat.format(
                                      checkOutItemController.totalCartTax.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: kWhiteLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomDivider(
                            height: screenSize.height * 0.001,
                            thickness: screenSize.height * 0.0005,
                            color: kWhiteLight,
                            margin: const EdgeInsets.all(0),
                          ),
                          Card(
                            elevation: 0,
                            color: isDarkMood
                                ? kDarkModeIconColor
                                : kLightModeBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(kTotalText,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kWhiteLight,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    nairaFormat.format(
                                      checkOutItemController
                                          .totalCartTotal.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: kWhiteLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
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
