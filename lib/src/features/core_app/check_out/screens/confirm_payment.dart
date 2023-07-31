import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/screens/add_debts.dart';
// import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/data/receipts_repo.dart';
// import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_screen.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/localizations/currency.dart';

import '../../../../common_widgets/common_widgets.dart';
// import '../../../../repository/hive_boxes.dart';
// import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
// import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
// import '../../store/domain/store_model.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final CartItemController cartItemController = Get.find();
    cartItemController.onInit();

    // int indexValue;

    // StoreModel store = storeBox.get(
    //   AddItemRepo.instance.currentStore.value,
    //   defaultValue: StoreModel(
    //     logo: null,
    //     storeName: '',
    //     bankName: '',
    //     accountNumber: '',
    //     contact: '',
    //     stock: [],
    //     receipts: [],
    //     debts: [],
    //     staff: [],
    //     sales: [],
    //     customer: [],
    //     storeId: '',
    //     categories: [],
    //   ),
    // );

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
                    if (cartItemController.isFirstTime.value &&
                        cartItemController.cartItems.isNotEmpty) {
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

                      cartItemController.isFirstTime.value = false;
                    }

                    return ListView.builder(
                      itemCount: cartItemController.cartItems.length,
                      itemBuilder: (context, index) {
                        var stockList = cartItemController.cartItems[index];
                        cartItemController.indexValue = index;

                        return SizedBox(
                          height: screenSize.height * 0.07,
                          child: Column(
                            children: [
                              if (index < cartItemController.cartItems.length)
                                GestureDetector(
                                  onHorizontalDragStart:
                                      (DragStartDetails details) {
                                    cartItemController
                                        .decreaseItemQuantityInCart(index);
                                  },
                                  onTap: () {
                                    cartItemController
                                        .increaseItemQuantityInCart(index);
                                  },
                                  onLongPress: () {
                                    cartItemController
                                        .deleteItemFromCart(index);
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
                                        padding: const EdgeInsets.all(8.0),
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
                                                  cartItemController
                                                      .cartItems[index]
                                                      .itemName,
                                                ),
                                                Text(
                                                  '${stockList.quantityInCart} x ${stockList.price}',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              nairaFormat.format(
                                                stockList.subTotal,
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
                                      cartItemController
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
                                      cartItemController
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
                                      cartItemController.totalCartTax.value,
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
                                      cartItemController.totalCartTotal.value,
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
            Padding(
              padding: EdgeInsets.all(screenSize.height * 0.05),
              child: ElevatedButton(
                onPressed: () {
                  cartItemController.showMoodOfPayment(
                    context,
                    screenSize,
                    isDarkMood,
                    cartItemController.indexValue,
                  );

                  // ReceiptsController.instance.cartTotal.value =
                  //     cartItemController.totalCartTotal.value.toString();
                  // AddReceiptsRepo.instance.saveReceiptData().then(
                  //       (value) => Get.to(
                  //         () => const ReceiptListScreen(),
                  //       ),
                  //     );
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
