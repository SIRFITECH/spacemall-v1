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

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final checkOutController = Get.put(CheckOutItemController());

    int tapedIndex = -1;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
          color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
        ),
        child: SingleChildScrollView(
          child: stockItemBox.isNotEmpty
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
                        itemCount: stockItemBox.length,
                        itemBuilder: (context, index) {
                          AddItemModel stockItem = stockItemBox.getAt(index);

                          return GestureDetector(
                            onTap: () {
                              int costOfItem = 1;
                              tapedIndex = index;
                              if (index == tapedIndex) {
                                checkOutController.increamentItems(
                                  index,
                                  tapedIndex,
                                );
                                (() {
                                  CheckOutItemController.instance.items.value =
                                      stockItem.itemCount++;
                                  CheckOutItemController.instance.items.value++;

                                  nairaFormat.format(
                                      int.parse(stockItem.itemSellingPrice));

                                  costOfItem = CheckOutItemController
                                              .instance.items.value <=
                                          0
                                      ? int.parse(stockItem.itemSellingPrice)
                                      : int.parse(stockItem.itemSellingPrice) *
                                          stockItem.itemCount;

                                  CheckOutItemController.instance.addToCart(
                                    CheckOutItemModel(
                                      itemId: stockItem.itemId,
                                      itemName: stockItem.itemName,
                                      quantityInCart: '${stockItem.itemCount}',
                                      price: nairaFormat.format(int.parse(
                                          stockItem.itemSellingPrice)),
                                      totalItemPrice:
                                          nairaFormat.format(costOfItem),
                                      totalCartPrice: 'totalCartPrice',
                                      subTotal: '$costOfItem',
                                      discount: CheckOutItemController
                                          .instance.totalCartDiscount.value
                                          .toString(),
                                      tax: CheckOutItemController
                                          .instance.totalCartTax.value
                                          .toString(),
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
                                          width: 100,
                                          height: 40,
                                          child: stockItem.itemPic == null
                                              ? SvgPicture.asset(
                                                  kImageIcon,
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
                                  () => checkOutController.tapedIndex.value ==
                                              index &&
                                          checkOutController.items.value > 0 &&
                                          tapedIndex == index
                                      ? Positioned(
                                          left: 6.5,
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
                                              'x${checkOutController.items.value.toString()}',
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
                    // Container(
                    //     padding: EdgeInsets.only(
                    //       top: screenSize.height * 0.23,
                    //       left: screenSize.height * 0.02,
                    //       right: screenSize.height * 0.02,
                    //     ),
                    //     width: double.infinity,
                    //     child: ElevatedButton(
                    //         onPressed: () {
                    //           Get.to(() => const ConfirmPayment());
                    //         },
                    //         child: const Text(kCheckOutText)))
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
