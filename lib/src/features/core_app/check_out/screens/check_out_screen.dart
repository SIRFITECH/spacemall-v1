import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/confirm_payment.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import '../../store/domain/store_model.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final cartItemController = Get.put(CartItemController());
    final AddItemRepo addItemRepo = Get.find();
    Get.put(
      ReceiptsController(),
    );
    int tapedIndex = -1;

    StoreModel store = storeBox.get(
      addItemRepo.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: [],
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );
    List<AddItemModel> stocks = store.stock.toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !isDarkMood
                ? const AssetImage(kBackGroundCart)
                : const AssetImage(kBackGroundCartDarkMood),
            fit: BoxFit.contain,
          ),
          color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
        ),
        child: SingleChildScrollView(
          child: stocks.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                        ),
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 10,
                          right: 10,
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: stocks.length,
                        itemBuilder: (context, index) {
                          AddItemModel stockItem = store.stock[index];

                          return GestureDetector(
                            onTap: () {
                              int costOfItem = 1;
                              tapedIndex = index;
                              if (index == tapedIndex) {
                                cartItemController.increamentItems(
                                  index,
                                  tapedIndex,
                                );
                                (() {
                                  CartItemController.instance.items.value =
                                      stockItem.itemCount++;
                                  CartItemController.instance.items.value++;

                                  nairaFormat.format(
                                      int.parse(stockItem.itemSellingPrice));

                                  costOfItem = CartItemController
                                              .instance.items.value <=
                                          0
                                      ? int.parse(stockItem.itemSellingPrice)
                                      : int.parse(stockItem.itemSellingPrice) *
                                          stockItem.itemCount;

                                  CartItemController.instance.addToCart(
                                    CartItemModel(
                                      itemId: stockItem.itemId,
                                      itemName: stockItem.itemName,
                                      quantityInCart: stockItem.itemCount,
                                      price: nairaFormat.format(int.parse(
                                          stockItem.itemSellingPrice)),
                                      totalItemPrice:
                                          nairaFormat.format(costOfItem),
                                      subTotal: costOfItem.toDouble(),
                                      discount: CartItemController
                                          .instance.totalCartDiscount.value,
                                      tax: CartItemController
                                          .instance.totalCartTax.value,
                                    ),
                                    context,
                                  );
                                })();
                              }
                            },
                            child: Stack(
                              children: [
                                Card(
                                  color: kWhiteLight,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width:
                                              //  screenSize.width * 0.4,
                                              100,
                                          height: screenSize.height * 0.039,
                                          // 40,
                                          child: stockItem.itemPic == null
                                              ? SvgPicture.asset(
                                                  kImageIcon,
                                                  // ignore: deprecated_member_use
                                                  color: kMainColorDark,
                                                  width: 50,
                                                  height: 70,
                                                  fit: BoxFit.scaleDown,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                      stockItem.itemPic!))),
                                      Text(
                                        stockItem.itemName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        nairaFormat.format(
                                          int.parse(stockItem.itemSellingPrice),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => cartItemController.tapedIndex.value ==
                                              index &&
                                          cartItemController.items.value > 0 &&
                                          tapedIndex == index
                                      ? Positioned(
                                          left: 4.3,
                                          top: 4.5,
                                          child: Container(
                                            height: 60,
                                            width: 80,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            child: Text(
                                              'x${cartItemController.items.value.toString()}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                )
              : SizedBox(
                  height: screenSize.height * 0.62,
                  child: const Center(child: Text(kCartEmptyText)),
                ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.23,
          left: screenSize.height * 0.05,
          right: screenSize.height * 0.02,
        ),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const ConfirmPayment());
          },
          child: const Text(kCheckOutText),
        ),
      ),
    );
  }
}
