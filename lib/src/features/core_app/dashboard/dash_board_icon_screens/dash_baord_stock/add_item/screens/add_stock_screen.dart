import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_button.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/custom_radio.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../../../../../repository/hive_boxes.dart';
import '../../../../../store/domain/store_model.dart';

class AddStock extends StatelessWidget {
  const AddStock({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final textTheme = Theme.of(context).textTheme;

    final AddItemController addItemController = Get.find();
    final AddCategoryController addCategoryController = Get.find();
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

    List<CategoryModel> categoriesFromBox =
        addCategoryController.getCategoriesFromBox();

    var itemPic = addItemController.itemPic;
    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'addstock in ${store.storeName}',
        automaticallyImplyLeading: true,
      ),
      drawer: const SpacemallDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            color: isDarkMood
                ? kDarkModeBackgroundColor.withOpacity(0.020)
                : kWhiteLight.withOpacity(0.1),
            height: screenSize.height * 0.85,
            child: GetBuilder<AddCategoryController>(
              builder: (addCategoryController) {
                // if (
                //     // store.categories.toList().isEmpty &&
                //     addCategoryController.noCategory.value == true) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     Get.defaultDialog(
                //       backgroundColor: !isDarkMood
                //           ? kDarkModeBackgroundColor.withOpacity(0.1)
                //           : kWhiteDark.withOpacity(0.1),
                //       title: kAddCategoryText,
                //       titleStyle: const TextStyle(
                //         color: kWhiteLight,
                //       ),
                //       content: const Text(
                //         kAddCategoryAlertBodyText,
                //         style: TextStyle(
                //           color: kWhiteLight,
                //         ),
                //       ),
                //       confirm: ElevatedButton(
                //         onPressed: () {
                //           Get.to(() => const AddCategory());
                //         },
                //         child: const Text(kOkayText),
                //       ),
                //     );
                //   });
                //   addCategoryController.noCategory.value = false;
                // }

                return Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.025),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          // Circular avartar for the item pic
                          Column(
                            children: [
                              // GetX<AddItemController>(
                              //     init: AddItemController(),
                              //     builder: (addItemController) {
                              //       return GestureDetector(
                              //         onTap: () => addItemController
                              //             .selectItemImage(context),
                              //         child: itemPic.value == null
                              //             ? CircleAvatar(
                              //                 radius: 40,
                              //                 backgroundColor:
                              //                     kDarkComplementColor
                              //                         .withOpacity(0.2),
                              //                 child: SizedBox(
                              //                   child: ClipOval(
                              //                     child: Padding(
                              //                       padding:
                              //                           const EdgeInsets.all(
                              //                               20.0),
                              //                       child: SvgPicture.asset(
                              //                         kImageIcon,
                              //                         // ignore: deprecated_member_use
                              //                         color: isDarkMood
                              //                             ? kDarkModeIconColor
                              //                             : kMainColorLight,
                              //                         width: 200,
                              //                         height: 200,
                              //                         fit: BoxFit.scaleDown,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               )
                              //             : CircleAvatar(
                              //                 radius: 40,
                              //                 backgroundImage:
                              //                     FileImage(itemPic.value!),
                              //               ),
                              //       );
                              //     }),

                              Obx(
                                () => GestureDetector(
                                  onTap: () => addItemController
                                      .selectItemImage(context),
                                  child: itemPic.value == null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundColor: kDarkComplementColor
                                              .withOpacity(0.2),
                                          child: SizedBox(
                                            child: ClipOval(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SvgPicture.asset(
                                                  kImageIcon,
                                                  // ignore: deprecated_member_use
                                                  color: isDarkMood
                                                      ? kDarkModeIconColor
                                                      : kMainColorLight,
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              FileImage(itemPic.value!),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  kProductPicText,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          // Column for name and category
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // row for name and category
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TextFeildWidget(
                                      screenSize: screenSize,
                                      isDarkMood: isDarkMood,
                                      controller: addItemController.itemName,
                                      keyboardType: TextInputType.text,
                                      hintText: '',
                                      labelText: kProductNameText,
                                      maxLines: 1,
                                      height: screenSize.height * 0.04,
                                      width: screenSize.width * 0.3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 6),
                                          child: Text(
                                            kProductCategoryText,
                                            style: textTheme.labelSmall,
                                          ),
                                        ),
                                        Obx(
                                          () => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenSize.height *
                                                    0.024.toDouble()),
                                            height: screenSize.height * 0.04,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: isDarkMood
                                                    ? kWhiteDark
                                                    : kBlackDark,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child:
                                                DropdownButton<CategoryModel>(
                                              underline: Container(
                                                height: 0,
                                              ),
                                              iconSize: 32,
                                              icon: Icon(
                                                Icons.arrow_drop_down_circle,
                                                size: 10,
                                                color: isDarkMood
                                                    ? kDarkModeIconColor
                                                    : kMainColorDark,
                                              ),
                                              value: addCategoryController
                                                  .categoryValue.value,
                                              hint: categoriesFromBox.isNotEmpty
                                                  ? Text(
                                                      truncateString(
                                                          'Choose Category', 9),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        debugPrint(
                                                            'Add Categroy tapped in AddStock ');

                                                        Get.to(() =>
                                                            const AddCategory());
                                                      },
                                                      child: Text(
                                                        truncateString(
                                                            'Add Category', 9),
                                                      ),
                                                    ),
                                              style: textTheme.labelSmall,
                                              elevation: 0,
                                              dropdownColor: MediaQuery.of(
                                                              context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? kWhiteLight
                                                  : kBlackDark,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              items: categoriesFromBox.map<
                                                      DropdownMenuItem<
                                                          CategoryModel>>(
                                                  (CategoryModel value) {
                                                return DropdownMenuItem<
                                                    CategoryModel>(
                                                  value: value,
                                                  child: Text(
                                                    truncateString(
                                                        value.categoryName, 9),
                                                    style: textTheme.labelSmall,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: addCategoryController
                                                  .setCategory,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // row for selling and cost price
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TextFeildWidget(
                                      screenSize: screenSize,
                                      isDarkMood: isDarkMood,
                                      controller: addItemController.costPrice,
                                      keyboardType: TextInputType.number,
                                      hintText: '',
                                      labelText: kCostPriceText,
                                      maxLines: 1,
                                      height: screenSize.height * 0.04,
                                      width: screenSize.width * 0.25,
                                    ),
                                  ),
                                  TextFeildWidget(
                                    screenSize: screenSize,
                                    isDarkMood: isDarkMood,
                                    controller: addItemController.sellingPrice,
                                    keyboardType: TextInputType.number,
                                    hintText: '',
                                    labelText: kSellingPriceText,
                                    maxLines: 1,
                                    height: screenSize.height * 0.04,
                                    width: screenSize.width * 0.25,
                                  ),
                                  Column(
                                    children: [
                                      Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: CustomRadio(
                                            onChange: (bool? value) =>
                                                addItemController
                                                    .setProfitTracking(),
                                            color: addItemController
                                                        .trackProfit.value ==
                                                    true
                                                ? isDarkMood
                                                    ? kDarkModeIconColor
                                                    : kMainColorDark
                                                : kGreyColor,
                                            groupValue: addItemController
                                                .trackProfit.value,
                                            value: addItemController
                                                .trackProfit.value,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenSize.width * 0.025),
                                        child: Text(
                                          kTrackProfitText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomDivider(
                        height: screenSize.width * 0.025,
                        thickness: screenSize.width * 0.004,
                        color: kGreyColor,
                        margin: const EdgeInsets.all(kDividerMargin),
                      ),
                      // Availaible stock and track low stock
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextFeildWidget(
                                screenSize: screenSize,
                                isDarkMood: isDarkMood,
                                controller: addItemController.stockAvailable,
                                keyboardType: TextInputType.number,
                                hintText: '',
                                labelText: kStockAvalableText,
                                maxLines: 1,
                                height: screenSize.height * 0.04,
                                width: screenSize.width * 0.5,
                              ),
                              Column(
                                children: [
                                  Obx(
                                    () => CustomRadio(
                                      onChange: (bool? value) =>
                                          addItemController
                                              .setLowStockTracking(),
                                      color: addItemController
                                                  .trackLowStock.value ==
                                              true
                                          ? isDarkMood
                                              ? kDarkModeIconColor
                                              : kMainColorDark
                                          : kGreyColor,
                                      groupValue:
                                          addItemController.trackLowStock.value,
                                      value:
                                          addItemController.trackLowStock.value,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenSize.width * 0.025),
                                    child: Text(
                                      kTrackLowStockText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => CustomRadio(
                                  onChange: (bool? value) => addItemController
                                      .setPreventItemSalesWhenOutOfStockTracking(),
                                  color: addItemController
                                              .preventItemSalesWhenOutOfStock
                                              .value ==
                                          true
                                      ? isDarkMood
                                          ? kDarkModeIconColor
                                          : kMainColorDark
                                      : kGreyColor,
                                  groupValue: addItemController
                                      .preventItemSalesWhenOutOfStock.value,
                                  value: addItemController
                                      .preventItemSalesWhenOutOfStock.value,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.025),
                                child: Text(
                                  kPreventSalesOnLowStockText,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // more images
                      CustomDivider(
                        height: screenSize.width * 0.025,
                        thickness: screenSize.width * 0.004,
                        color: kGreyColor,
                        margin: const EdgeInsets.all(0),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(kAddMoreImagesText),
                          Obx(() {
                            return SizedBox(
                              height: screenSize.height * 0.08,
                              width: double.infinity,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemCount:
                                    addItemController.moreImages.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      addItemController.moreImages.length) {
                                    File image =
                                        addItemController.moreImages[index];
                                    return GestureDetector(
                                      // onTap: () {
                                      //   addItemController
                                      //       .showDeleteImageAlert(
                                      //     context,
                                      //     index,
                                      //     isDarkMood,
                                      //   );
                                      // },
                                      onTap: () {
                                        addItemController.showDeleteImageAlert(
                                          context,
                                          isDarkMood,
                                          () {
                                            addItemController.removeImage(
                                                context, index);
                                          },
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: screenSize.height * 0.07,
                                          width: screenSize.width * 0.15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              style: BorderStyle.solid,
                                              color:
                                                  kGreyColor.withOpacity(0.3),
                                            ),
                                          ),
                                          child: Image.file(
                                            image,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        addItemController.addImage(context);
                                      },
                                      child: Container(
                                        height: screenSize.height * 0.07,
                                        width: screenSize.width * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: kGreyColor.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: kGreyColor.withOpacity(0.3),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      CustomDivider(
                        height: screenSize.width * 0.025,
                        thickness: screenSize.width * 0.004,
                        color: kGreyColor,
                        margin: const EdgeInsets.all(0),
                      ),
                      // expiry date
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateFeildWidget(
                              screenSize: screenSize,
                              isDarkMood: isDarkMood,
                              controller: addItemController.trackExpiry,
                              keyboardType: TextInputType.datetime,
                              hintText: kDateHintText,
                              labelText: kTrackExpiryDateText,
                              maxLines: 1,
                              height: screenSize.height * 0.04,
                              width: screenSize.width * 0.4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateFeildWidget(
                              screenSize: screenSize,
                              isDarkMood: isDarkMood,
                              controller: addItemController.expiryAlert,
                              keyboardType: TextInputType.datetime,
                              hintText: kDateHintText,
                              labelText: kExpiryDateAlertText,
                              maxLines: 1,
                              height: screenSize.height * 0.04,
                              width: screenSize.width * 0.4,
                            ),
                          ),
                        ],
                      ),

                      CustomDivider(
                        height: screenSize.width * 0.025,
                        thickness: screenSize.width * 0.004,
                        color: kGreyColor,
                        margin: const EdgeInsets.all(0),
                      ),
                      // add item button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            screenSize: screenSize,
                            onPress: ()
                                // =>
                                {
                              AddItemController.instance.addItemToPhone();

                              print(
                                  'items in category is ${AddCategoryController.instance.categoryValue.value?.itemsInCategory}');
                            },
                            title: kAddStockAppBarText,
                            width: screenSize.width * 0.3,
                          ),
                        ],
                      ),

                      // variants
                      const Text(kVariantsText),
                      CustomDivider(
                        height: screenSize.width * 0.025,
                        thickness: screenSize.width * 0.004,
                        color: kGreyColor,
                        margin: const EdgeInsets.all(0),
                      ),
                      const Text('Variant text bottun'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
