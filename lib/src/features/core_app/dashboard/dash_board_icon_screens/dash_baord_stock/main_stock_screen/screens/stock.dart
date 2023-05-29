// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/login/login_divider_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/add_items.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // final brightness = media.platformBrightness;
    // final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final stockController = Get.put(StockController());
    final addItemController = Get.put(AddItemController());
    final addItemRepo = Get.put(AddItemRepo());

    return Scaffold(
      appBar: AppBar(
        title: const Text(kStockManagentText),
        centerTitle: true,
      ),
      /**
       * Drawer that expose the menu options on the side
       * The SpacemallDrawer() is located in .../widgets/navWidgets/drawer.dart
       */
      // drawer: const SpacemallDrawer(),
      body: Container(
        // color: isDarkMood?:,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(kBackGroundCart),
          fit: BoxFit.contain,
        )),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    kStockManagentText,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: LoginDivider(height: 5),
                  ),
                ],
              ),
            ),

            // Card below the "Stock Managment" bold text
            // located in ...spacemall/spacemall/lib/widgets/componentWidgets/addItemsCard.dart
            AddItemsCard(items: stockController.items),

            Container(
                padding: const EdgeInsets.only(top: 10),
                height: screenSize.height * 0.71,
                width: double.infinity,
                child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                      ),
                      itemCount: stockItemBox.length,
                      itemBuilder: (context, index) {
                        AddItemModel stockItem = stockItemBox.getAt(index);
                        return GestureDetector(
                          onTap: () {
                            // variable to hold the state of the card, whetehr pressed or not
                            bool cardState = addItemController.isPressed.value;
                            // varaible to track item taped
                            var tapIndex = index;
                            if (index == tapIndex) {
                              addItemController
                                  .increaementSelectedItem(tapIndex);
                              AddItemModel selectedStockItem =
                                  stockItemBox.getAt(tapIndex);
                              cardState = true;
                              print(selectedStockItem.itemCategory);
                              debugPrint('$tapIndex');
                            }
                          },
                          child: Stack(
                            children: [
                              Card(
                                color: kBrighComplementColor,
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 6),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor:
                                                      kMainComplimemtColorDark
                                                          .withOpacity(0.2),
                                                  child: SizedBox(
                                                      child: ClipOval(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: // check if the image placeholder is empty, get image from
                                                          // sharedPreferences, otherwise, display the icon
                                                          stockItem.itemPic ==
                                                                  null
                                                              ? SvgPicture
                                                                  .asset(
                                                                  kImageIcon,
                                                                  color:
                                                                      kMainColorDark,
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 60,
                                                                  backgroundImage:
                                                                      FileImage(
                                                                          stockItem
                                                                              .itemPic!),
                                                                ),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      stockItem.itemName,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kBlackDark,
                                                          fontSize: 19),
                                                    ),
                                                    Text(
                                                      stockItem.itemCategory,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kBlackDark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'N ${stockItem.itemSellingPrice}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kMainColorLight,
                                                ),
                                              ),
                                              Text(
                                                "${stockItem.itemQuantity} in stock",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackDark,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // `SizedBox(
                                    //   height: 45,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(
                                    //         bottom: 8.0, left: 8),
                                    //     child:
                                    //     ListView(
                                    //       scrollDirection: Axis.horizontal,
                                    //       children: [
                                    //         SizeButton(
                                    //           title: 'Small',
                                    //           action: () {},
                                    //           color: kMainColor,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 5,
                                    //         ),
                                    //         SizeButton(
                                    //           title: 'Small',
                                    //           action: () {},
                                    //           color: kMainColor,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 5,
                                    //         ),
                                    //         SizeButton(
                                    //           title: 'Small',
                                    //           action: () {},
                                    //           color: kMainColor,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 5,
                                    //         ),
                                    //         SizeButton(
                                    //           title: 'Small',
                                    //           action: () {},
                                    //           color: kMainColor,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 5,
                                    //         ),
                                    //       ],
                                    //     ),

                                    //   ),
                                    // ),`
                                  ],
                                ),
                              ),
                              if (addItemController.isPressed.value = true)
                                Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    addItemController.numSelectedItems
                                        .toString(),
                                    // Display the index number as overlay
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );

                        // Card(
                        //   child: Title(
                        //       color: kMainColorDark,
                        //       child: Column(
                        //         children: [
                        //           Text(stockItem.itemName),
                        //           Text(stockItem.itemCategory),
                        //           // Text(stockItem.itemSellingPrice),
                        //           // Text(stockItem.itemQuantity),
                        //         ],
                        //       )),
                        // );
                      }),
                )
                // : Column(
                //     children: [
                //       Text('Add Item'),
                //     ],
                //   ),
                )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => addItemRepo.printHiveBox(stockItemBox),
        //     {
        //   print(
        //       'there are ${stockItemBox.length} items saved in the phone storage ');
        //   print(
        //       'The observable list has ${addItemController.itemList.length} items, ');
        // },
        // =>
        // addItemRepo.deleteLastItemFromPhone(),
        backgroundColor: const Color(0xffffb31a),
        child: const Icon(
          Icons.add,
          color: kWhiteDark,
        ),
      ),
    );
  }
}
