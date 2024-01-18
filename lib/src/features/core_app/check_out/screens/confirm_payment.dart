import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/cart_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/screens/add_debts.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/localizations/currency.dart';

import '../../../../common_widgets/common_widgets.dart';
import '../application/check_out_controller.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final CartItemController cartItemController = Get.find();
    final CheckOutController checkOutController = Get.find();
    cartItemController.onInit();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Checkout ',
        automaticallyImplyLeading: true,
      ),
      drawer: const SpacemallDrawer(),
      body: Container(
        height: screenSize.height * 0.9,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !isDarkMood
                ? const AssetImage(kBackGroundCart)
                : const AssetImage(kBackGroundCartDarkMood),
            fit: BoxFit.contain,
          ),
        ),
        child: ListView(
          children: [
            // list of items in the cart
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: isDarkMood
                      ? kDarkModeBackgroundColor.withOpacity(0.1)
                      : kLightModeBackgroundColor.withOpacity(0.1),
                  height: screenSize.height * 0.5,
                  child: Obx(() {
                    if (checkOutController.isFirstTime.value &&
                        checkOutController.cartItems.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.defaultDialog(
                          backgroundColor: !isDarkMood
                              ? kDarkModeBackgroundColor.withOpacity(0.1)
                              : kWhiteDark.withOpacity(0.1),
                          title: kAdjustCartItemText,
                          titleStyle: const TextStyle(
                            color: kWhiteLight,
                            fontWeight: FontWeight.w900,
                            fontSize: kBodyTextFont,
                          ),
                          content: const Text(
                            kAlertBodyText,
                            style: TextStyle(
                              color: kWhiteLight,
                              fontSize: kBodyTextFont,
                            ),
                          ),
                          confirm: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              kOkayText,
                              style: TextStyle(
                                fontSize: kBodyTextFont,
                              ),
                            ),
                          ),
                        );
                      });

                      checkOutController.isFirstTime.value = false;
                    }

                    return ListView.builder(
                      itemCount: checkOutController.cartItems.length,
                      itemBuilder: (context, index) {
                        var stockList = checkOutController.cartItems[index];
                        checkOutController.indexValue = index;

                        return SizedBox(
                          height: screenSize.height * 0.07,
                          child: Column(
                            children: [
                              if (index < checkOutController.cartItems.length)
                                GestureDetector(
                                  onHorizontalDragStart:
                                      (DragStartDetails details) {
                                    checkOutController
                                        .decreaseItemQuantityInCart(index);
                                  },
                                  onTap: () {
                                    checkOutController
                                        .increaseItemQuantityInCart(index);
                                  },
                                  onLongPress: () {
                                    checkOutController
                                        .removeItemFromCart(index);
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: screenSize.height * 0.07,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        side: BorderSide(
                                          color: !isDarkMood
                                              ? kTextFieldLightBorderColor
                                                  .withOpacity(0.5)
                                              : kTextFieldDarkBorderColor
                                                  .withOpacity(0.5),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  checkOutController
                                                      .cartItems[index]
                                                      .itemName,
                                                  style: const TextStyle(
                                                      fontSize: kBodyTextFont),
                                                ),
                                                Obx(
                                                  () => Text(
                                                    '${stockList.quantityInCart} x ${stockList.price}',
                                                    style: const TextStyle(
                                                      fontSize: kBodyTextFont,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => Text(
                                                nairaFormat.format(
                                                  stockList.subTotal.value,
                                                ),
                                                style: const TextStyle(
                                                  fontSize: kBodyTextFont,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
            // payment subtotal and total
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: isDarkMood
                      ? kDarkModeIconColor
                      : kLightModeBackgroundColor,
                  height: screenSize.height * 0.18,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  kSubTotalText,
                                  style: TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  nairaFormat.format(
                                    checkOutController.totalCartSubTotal.value,
                                  ),
                                  style: const TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  kDiscountText,
                                  style: TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  nairaFormat.format(
                                    checkOutController.totalCartDiscount.value,
                                  ),
                                  style: const TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  kTaxText,
                                  style: TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  nairaFormat.format(
                                    checkOutController.totalCartTax.value,
                                  ),
                                  style: const TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  kTotalText,
                                  style: TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  nairaFormat.format(
                                    checkOutController.totalCartTotal.value,
                                  ),
                                  style: const TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // paylater or add to debts
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
                      Get.to(() => const AddToDebt());
                    },
                    child: ClickableText(
                        isDarkMood: isDarkMood, text: kPayLaterText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DashBoard());
                    },
                    child: ClickableText(
                      isDarkMood: isDarkMood,
                      text: kAddItemText,
                    ),
                  ),
                ],
              ),
            ),
            // confirm payment button
            Padding(
              padding: EdgeInsets.all(screenSize.height * 0.05),
              child: ElevatedButton(
                onPressed: () {
                  checkOutController.showModeOfPayment(
                    context,
                    screenSize,
                    isDarkMood,
                    checkOutController.indexValue,
                  );
                },
                child: const Text(
                  kConfirmPaymentText,
                  style: TextStyle(fontSize: kBodyTextFont, color: kWhiteLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
