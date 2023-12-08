import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/check_out/application/cart_item_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../../repository/hive_boxes.dart';
import '../../store/domain/store_model.dart';
import '../application/check_out_controller.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final cartItemController = Get.put(CartItemController());

    final checkOutController = Get.put(CheckOutController());

    int tapedIndex = -1;
    // int tapedIndex = -1;

    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
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
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Check Out ',
        automaticallyImplyLeading: false,
      ),
      body: store.storeName == ''
          ? const Center(
              child: Text(
                  'Please choose a store \n Or add store from the menu icon \n On your top left hand of the previous screen to continue'),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: !isDarkMood
                      ? const AssetImage(kBackGroundCart)
                      : const AssetImage(kBackGroundCartDarkMood),
                  fit: BoxFit.contain,
                ),
                color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
              ),
              child: stocks.isNotEmpty
                  ? checkOutAllExpandible(screenSize, store, isDarkMood, stocks,
                      tapedIndex, cartItemController)
                  : SizedBox(
                      height: screenSize.height * 0.7,
                      child: const Center(child: Text(kCartEmptyText)),
                    ),
            ),
      floatingActionButton: store.storeName == ''
          ? const Center(
              child: Text(''),
            )
          : Container(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.35,
                left: screenSize.height * 0.05,
                right: screenSize.height * 0.02,
              ),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // var receipt = await SalesPhoneService().getSalesFromDevice(
                  //     '4b04703c-2667-47a5-93a1-d8e624e7df82');
                  // print('From the Checkout screen $receipt');
                  checkOutController.moveToConfirmPayment();
                },
                child: const Text(kCheckOutText),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Padding checkOutAllExpandible(
    Size screenSize,
    StoreModel store,
    bool isDarkMood,
    List<AddItemModel> stocks,
    int tapedIndex,
    CartItemController cartItemController,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.05,
      ),
      child: ListView.builder(
        itemCount: store.categories.length + 1,
        itemBuilder: (context, index) {
          int alItemsInCategory =
              AddItemController.instance.allItemsInStore(store);
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 1.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: isDarkMood
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1),
                      ),
                      child: ExpandableTheme(
                        data: ExpandableThemeData(
                          iconColor: !isDarkMood ? kBlackDark : kWhiteLight,
                        ),
                        child: ExpandablePanel(
                          header: ListTile(
                            selected: AddItemController.instance
                                    .selectedAllItemsCategoryIndex.value ==
                                -1,
                            selectedColor: Colors.green,
                            onTap: () {
                              // AddItemController.instance
                              //     .setSelectedAllItemsCategory(-1);
                            },
                            title: CheckOutCategory(
                              categoryTitle: 'All Items',
                              isDarkMood: isDarkMood,
                            ),
                            subtitle: CheckOutCategoryQuantityString(
                                alItemsInCategory: alItemsInCategory),
                          ),
                          collapsed: const Text(
                            '',
                            style: TextStyle(fontSize: 12),
                          ),
                          expanded: GetBuilder<AddItemController>(
                            builder: (addItemController) => GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                              ),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: stocks.length,
                              itemBuilder: (context, index) {
                                AddItemModel stockItem = store.stock[index];
                                if (int.parse(stockItem.itemQuantity) <= 0) {
                                  return Stack(
                                    children: [
                                      Card(
                                        color: kWhiteLight,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: screenSize.height * 0.039,
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
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.file(
                                                        stockItem.itemPic!,
                                                      ),
                                                    ),
                                            ),
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
                                                int.parse(
                                                    stockItem.itemSellingPrice),
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isDarkMood
                                                ? Colors.black.withOpacity(0.35)
                                                : Colors.black.withOpacity(0.1),
                                          ),
                                          width: screenSize.width * 0.2,
                                          height: screenSize.height * 0.03,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return GestureDetector(
                                    // this tap event registers a tap on the item in the allItem section of the cart
                                    onTap: () {
                                      int costOfItem = 1;
                                      tapedIndex = index;

                                      if (index == tapedIndex) {
                                        cartItemController.increamentItems(
                                          index,
                                          tapedIndex,
                                        );
                                        (() {
                                          // Check if the number of items in store is greater than the number of items in cart

                                          if (stockItem.itemCount <
                                              int.parse(
                                                stockItem.itemQuantity,
                                              )) {
                                            CartItemController.instance.items
                                                .value = stockItem.itemCount++;
                                            CartItemController
                                                .instance.items.value++;
                                          }
                                          nairaFormat.format(
                                            int.parse(
                                              stockItem.itemSellingPrice,
                                            ),
                                          );

                                          costOfItem = CartItemController
                                                      .instance.items.value <=
                                                  0
                                              ? int.parse(
                                                  stockItem.itemSellingPrice)
                                              : (int.parse(stockItem
                                                          .itemSellingPrice) *
                                                      stockItem.itemCount)
                                                  .toInt();
                                          CheckOutController.instance.addToCart(
                                            CartItemModel(
                                              itemId: stockItem.itemId,
                                              itemName: stockItem.itemName,
                                              quantityInCart:
                                                  RxInt(stockItem.itemCount),
                                              price: nairaFormat.format(
                                                  int.parse(stockItem
                                                      .itemSellingPrice)),
                                              totalItemPrice: nairaFormat
                                                  .format(costOfItem),
                                              subTotal: RxDouble(
                                                  costOfItem.toDouble()),
                                              discount: CheckOutController
                                                  .instance
                                                  .totalCartDiscount
                                                  .value,
                                              tax: CheckOutController
                                                  .instance.totalCartTax.value,
                                            ),
                                            context,
                                          );
                                          // check if item is in cart already - add item if false
                                          // else if true, check if quantity in cart is less that quantity in store
                                          // if false throw limit error
                                          // else if true, increament the stock in cart
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
                                                  width: screenSize.width * 0.5,
                                                  height:
                                                      screenSize.height * 0.039,
                                                  child: stockItem.itemPic ==
                                                          null
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
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.file(
                                                              stockItem
                                                                  .itemPic!))),
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
                                                  int.parse(stockItem
                                                      .itemSellingPrice),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(
                                          () => cartItemController
                                                          .tapedIndex.value ==
                                                      index &&
                                                  cartItemController
                                                          .items.value >
                                                      0 &&
                                                  tapedIndex == index
                                              //  &&
                                              // cartItemController.isInCart.value ==
                                              //     true
                                              ? Positioned(
                                                  left: 4.3,
                                                  top: 4.5,
                                                  child: Container(
                                                    height: screenSize.height *
                                                        0.06,
                                                    width: screenSize.width *
                                                        0.295,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    child: Text(
                                                      'x${cartItemController.items.value.toString()}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            );
          } else {
            // Other categories
            final categoryIndex = index - 1;
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 1.0,
              ),
              child: SizedBox(
                width: screenSize.width * 0.18,
                child: Column(
                  children: [
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          borderRadius: store.categories[categoryIndex] ==
                                  store.categories.last
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))
                              : null,
                          color: isDarkMood
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.1),
                        ),
                        child: ExpandableTheme(
                          data: ExpandableThemeData(
                              iconColor:
                                  !isDarkMood ? kBlackDark : kWhiteLight),
                          child: ExpandablePanel(
                            header: ListTile(
                                selected: AddItemController
                                        .instance.selectedCategoryIndex.value ==
                                    -1,
                                selectedColor: Colors.green,
                                onTap: () {
                                  AddItemController.instance
                                      .setSelectedCategoryIndex(categoryIndex);
                                },
                                title: CheckOutCategory(
                                  categoryTitle: store
                                      .categories[categoryIndex].categoryName,
                                  isDarkMood: isDarkMood,
                                ),
                                subtitle: CheckOutCategoryQuantityString(
                                  alItemsInCategory: int.parse(
                                    truncateString(
                                        store.categories[categoryIndex]
                                            .itemsInCategory
                                            .toString(),
                                        6),
                                  ),
                                )),
                            collapsed: const Text(
                              '',
                              style: TextStyle(fontSize: 12),
                            ),
                            expanded: GetBuilder<AddItemController>(
                              builder: (addItemController) => GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                ),
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: store
                                    .categories[categoryIndex].itemsInCategory,
                                itemBuilder: (context, index) {
                                  AddItemModel stockItem = store
                                      .categories[categoryIndex].items[index];

                                  if (int.parse(stockItem.itemQuantity) <= 0) {
                                    return Stack(
                                      children: [
                                        Card(
                                          color: kWhiteLight,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width:
                                                    //  screenSize.width * 0.4,
                                                    100,
                                                height:
                                                    screenSize.height * 0.039,
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
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.file(
                                                          stockItem.itemPic!,
                                                        ),
                                                      ),
                                              ),
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
                                                  int.parse(stockItem
                                                      .itemSellingPrice),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: isDarkMood
                                                  ? Colors.black
                                                      .withOpacity(0.35)
                                                  : Colors.black
                                                      .withOpacity(0.1),
                                            ),
                                            width: screenSize.width * 0.2,
                                            height: screenSize.height * 0.03,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    // var category = store
                                    //     .categories[categoryIndex].categoryName;

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
                                            // Check if the number of items in store is greater than the number of items in cart

                                            if (stockItem.itemCount <
                                                int.parse(
                                                    stockItem.itemQuantity)) {
                                              CartItemController
                                                      .instance.items.value =
                                                  stockItem.itemCount++;
                                              CartItemController
                                                  .instance.items.value++;
                                            }
                                            nairaFormat.format(int.parse(
                                                stockItem.itemSellingPrice));

                                            costOfItem = CartItemController
                                                        .instance.items.value <=
                                                    0
                                                ? int.parse(
                                                    stockItem.itemSellingPrice)
                                                : (int.parse(stockItem
                                                            .itemSellingPrice) *
                                                        stockItem.itemCount)
                                                    .toInt();

                                            CheckOutController.instance
                                                .addToCart(
                                              CartItemModel(
                                                itemId: stockItem.itemId,
                                                itemName: stockItem.itemName,
                                                quantityInCart:
                                                    RxInt(stockItem.itemCount),
                                                price: nairaFormat.format(
                                                    int.parse(stockItem
                                                        .itemSellingPrice)),
                                                totalItemPrice: nairaFormat
                                                    .format(costOfItem),
                                                subTotal: RxDouble(
                                                    costOfItem.toDouble()),
                                                discount: CheckOutController
                                                    .instance
                                                    .totalCartDiscount
                                                    .value,
                                                tax: CheckOutController.instance
                                                    .totalCartTax.value,
                                              ),
                                              context,
                                            );
                                            // check if item is in cart already - add item if false
                                            // else if true, check if quantity in cart is less that quantity in store
                                            // if false throw limit error
                                            // else if true, increament the stock in cart
                                          })();
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          checkOutItemCard(
                                              screenSize, stockItem, context),
                                          Obx(
                                            () => cartItemController
                                                            .tapedIndex.value ==
                                                        index &&
                                                    cartItemController
                                                            .items.value >
                                                        0 &&
                                                    tapedIndex == index
                                                ? checkOutLayOver(screenSize,
                                                    cartItemController)
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Card checkOutItemCard(
      Size screenSize, AddItemModel stockItem, BuildContext context) {
    return Card(
      color: kWhiteLight,
      child: Column(
        children: [
          SizedBox(
            width: screenSize.width * 0.5,
            height: screenSize.height * 0.039,
            child: stockItem.itemPic == null
                ? SvgPicture.asset(
                    kImageIcon,
                    // ignore: deprecated_member_use
                    color: kMainColorDark,
                    width: 50,
                    height: 140,
                    fit: BoxFit.scaleDown,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      stockItem.itemPic!,
                    ),
                  ),
          ),
          Text(
            stockItem.itemName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            nairaFormat.format(
              int.parse(stockItem.itemSellingPrice),
            ),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Positioned checkOutLayOver(
      Size screenSize, CartItemController cartItemController) {
    return Positioned(
      left: 4.3,
      top: 4.5,
      child: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width * 0.295,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
    );
  }
}

class CheckOutCategoryQuantityString extends StatelessWidget {
  const CheckOutCategoryQuantityString({
    super.key,
    required this.alItemsInCategory,
  });

  final int alItemsInCategory;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$alItemsInCategory',
      style: const TextStyle(fontSize: 15),
    );
  }
}

class CheckOutCategory extends StatelessWidget {
  const CheckOutCategory({
    required this.categoryTitle,
    required this.isDarkMood,
    super.key,
  });

  final String categoryTitle;
  final bool isDarkMood;

  @override
  Widget build(BuildContext context) {
    return Text(
      categoryTitle,
      style: TextStyle(
        fontSize: 17,
        color: !isDarkMood ? kBlackDark : kWhiteLight,
      ),
    );
  }
}
