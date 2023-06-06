import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/confirm_payment.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
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
      backgroundColor: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
          //   color: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
          //   borderRadius: const BorderRadius.only(
          //     bottomLeft: Radius.circular(20),
          //     bottomRight: Radius.circular(20),
          //   ),
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
                              // checkOutController.setNumberOfItemSelect(index);
                              if (index == tapedIndex) {
                                checkOutController.increamentItems(
                                  index,
                                  tapedIndex,
                                );
                                (() {
                                  CheckOutItemController.instance.items.value =
                                      stockItem.itemCount++;
                                  // set total price of item
                                  costOfItem = CheckOutItemController
                                              .instance.items.value <=
                                          0
                                      ? int.parse(stockItem.itemSellingPrice)
                                      : int.parse(stockItem.itemSellingPrice) *
                                          stockItem.itemCount;
                                })();
                                print(
                                    'It costs N$costOfItem for ${stockItem.itemCount} ${stockItem.itemName}');
                                print(
                                    '${stockItem.itemName} is pressed ${CheckOutItemController.instance.items.value} times');
                              }
                            },
                            child: Stack(
                              children: [
                                Card(
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
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'N${stockItem.itemSellingPrice}',
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => checkOutController.tapedIndex.value ==
                                          index
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
                                              // 'x${stockItem.itemCount}',
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
                    Container(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.23,
                          left: screenSize.height * 0.02,
                          right: screenSize.height * 0.02,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              // checkOutRepo.addProductToCart();
                              Get.to(() => const ConfirmPayment());
                            },
                            child: const Text('Check Out')))
                  ],
                )
              : SizedBox(
                  height: screenSize.height * 0.5,
                  child: const Center(child: Text('Cart empty')),
                ),
        ),
      ),
    );
  }
}
