import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/login/login_divider_widget.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_itme_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/add_items.dart';

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

            FutureBuilder<List<AddItemModel>?>(
              future: addItemRepo.getDataFromPhone(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final itemList = snapshot.data ?? [];

                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: screenSize.height * 0.71,
                  width: double.infinity,
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                      ),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        // Access the item from the list using the index
                        final item = itemList[index];

                        // // Access the properties of the item
                        final itemPic = item.itemPic;

                        print('the item list is ${itemList.length}');

                        return GestureDetector(
                          onTap: () {
                            var tapIndex = index;
                            if (index == tapIndex) {
                              debugPrint('$tapIndex');
                            }
                          },
                          child: Card(
                            color: kBrighComplementColor,
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      const EdgeInsets.all(1.0),
                                                  child: // check if the image placeholder is empty, get image from
                                                      // sharedPreferences, otherwise, display the icon
                                                      itemPic == null
                                                          ? SvgPicture.asset(
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
                                                                      itemPic),
                                                            ),
                                                ),
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.itemName,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kBlackDark,
                                                      fontSize: 19),
                                                ),
                                                Text(
                                                  item.itemCategory,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                            item.itemSellingPrice,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kMainColorLight,
                                            ),
                                          ),
                                          Text(
                                            item.itemQuantity,
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
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
            //  {},
            =>
            addItemRepo.deleteLastItemFromPhone(),
        backgroundColor: const Color(0xffffb31a),
        child: const Icon(
          Icons.add,
          color: kWhiteDark,
        ),
      ),
    );
  }
}
