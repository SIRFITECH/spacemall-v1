import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/login/login_divider_widget.dart';
import 'package:spacemall/src/features/core_app/check_out/data/check_out_repo.dart';
// import 'package:spacemall/src/features/core_app/check_out/screens/check_out_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/add_items.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/edit_item.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/localizations/currency.dart';
// import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../../../../../../utils/helpers/helper.dart';
import '../../../../../store/application/store_controller.dart';
// import '../../../../../store/domain/store_model.dart';

class Stock extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Stock({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final StockController stockController = Get.find();
    final AddItemRepo addItemRepo = Get.find();
    AddItemRepo.instance.setStockList();
    final StoreController storeController = Get.find();
    print(
        ' THE PRESENT VALUE OF NOSTOREYET IS ${storeController.noStoreYet.value} IN THE STOCK SCREEN');

    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} stock',
        automaticallyImplyLeading: true,
      ),

      drawer: const SpacemallDrawer(),
      // Showcase(
      //   key: keyTwo,
      //   description: 'Click to add and select the "Add a Store Menu"',
      //   child:
      // ),

      //  Showcase(
      //   key: keyTwo,
      //   description: 'Press on the menu to add a new store',
      //   child:
      // ),
      body: storeController.noStoreYet.value == true
          ? Center(
              child: Container(
                child: const Text(
                    'Please choose a store \n Or add store from the menu icon \n On your top left hand to continue'),
              ),
            )
          : Container(
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            kStockManagentText.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Arial Rounded',
                              color: isDarkMood
                                  ? kWhiteLight
                                  : kDarkComplementColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: LoginDivider(
                            height: 5,
                            thickness: 3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // located in ...spacemall/spacemall/lib/widgets/componentWidgets/addItemsCard.dart
                  AddItemsCard(items: stockController.items),

                  // stockBox.isNotEmpty
                  //     ?
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: screenSize.height * 0.71,
                    width: double.infinity,
                    child: SizedBox(
                      height: 30,
                      child: Scrollbar(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                          ),
                          itemCount: addItemRepo.stockList.length,
                          itemBuilder: (context, index) {
                            AddItemModel stockItem =
                                addItemRepo.stockList[index];

                            return GestureDetector(
                              onTap: () {
                                var tapIndex = index;
                                if (index == tapIndex) {
                                  Get.to(() => EditItem(item: stockItem));
                                  // AddItemRepo.instance.editItemData(stockItem);
                                  debugPrint(stockItem.itemId);
                                }
                              },
                              child: Column(
                                children: [
                                  Card(
                                    color: !isDarkMood
                                        ? kWhiteLight
                                        : kDarkModeBackgroundColor
                                            .withOpacity(0.7),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          kMainComplimemtColorDark
                                                              .withOpacity(0.2),
                                                      child: SizedBox(
                                                        child: ClipOval(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: stockItem
                                                                        .itemPic ==
                                                                    null
                                                                ? SvgPicture
                                                                    .asset(
                                                                    kImageIcon,
                                                                    // ignore: deprecated_member_use
                                                                    color:
                                                                        kMainColorDark,
                                                                    width: 100,
                                                                    height: 100,
                                                                    fit: BoxFit
                                                                        .scaleDown,
                                                                  )
                                                                : CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundImage:
                                                                        FileImage(
                                                                      stockItem
                                                                          .itemPic!,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          stockItem.itemName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isDarkMood
                                                                  ? kWhiteLight
                                                                  : kBlackDark,
                                                              fontSize: 19),
                                                        ),
                                                        Text(
                                                          stockItem
                                                              .itemCategory!,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDarkMood
                                                                ? kGreyColor
                                                                : kBlackDark,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    nairaFormat.format(
                                                        int.parse(stockItem
                                                            .itemSellingPrice)),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kMainColorLight,
                                                    ),
                                                  ),
                                                  int.parse(stockItem
                                                              .itemQuantity) <
                                                          0
                                                      ? Text(
                                                          "${stockItem.itemQuantity} in stock",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            // color: isDarkMood
                                                            //     ? kGreyColor
                                                            //     : kBlackDark,
                                                            color: kRedColor,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      : Text(
                                                          "${stockItem.itemQuantity} in stock",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDarkMood
                                                                ? kGreyColor
                                                                : kBlackDark,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            child: LoginDivider(
                                                height: 0, thickness: 3)),
                                        SizedBox(
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7, bottom: 5),
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                  ),
                                                  child: const Text('Small'),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        kLightModeInactiveButtonColor
                                                            .withOpacity(0.3),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                  ),
                                                  child: const Text('Meduim'),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => const CheckOut());
          CheckOutRepo.instance.increamentCount();
        },
        // => addItemRepo.printHiveBox(stockBox),
        //     {
        //   print(
        //       'there are ${stockBox.length} items saved in the phone storage ');
        //   print(
        //       'The observable list has ${addItemController.itemList.length} items, ');
        // },
        // =>
        // addItemRepo.deleteLastItemFromPhone(),
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
