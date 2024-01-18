import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';
import '../../../../../../../constants/colors.dart';
import '../../../../../../../constants/image_strings.dart';
import '../../../../../../../constants/sizes.dart';
import '../../../../../../../constants/text_strings.dart';
import '../../../../../../../utils/helpers/helper.dart';
import '../../../../../general/custom_button.dart';
import '../../../../../general/custom_divider.dart';
import '../../../../../general/custom_radio.dart';
import '../../../../../general/my_app_bar.dart';
import '../../../../../profile/screens/text_feild_widget.dart';
import '../../add_category/application/add_category_controller.dart';
import '../../add_category/domain/category_model.dart';
import '../../add_item/application/add_item_controller.dart';
import '../../add_item/domain/add_item_model.dart';

class EditItem extends StatelessWidget {
  const EditItem({
    super.key,
    required this.item,
  });

  final AddItemModel item;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final textTheme = Theme.of(context).textTheme;

    final AddItemController addItemController = Get.find();
    final AddCategoryController addCategoryController = Get.find();

    List<CategoryModel> categoriesFromBox =
        addCategoryController.getCategoriesFromBox();

    var itemPic = addItemController.itemPic;
    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Edit ${item.itemName} in store',
        automaticallyImplyLeading: false,
      ),
      // drawer: const SpacemallDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: isDarkMood
                    ? kDarkModeBackgroundColor.withOpacity(0.020)
                    : kWhiteLight.withOpacity(0.1),
                height: screenSize.height * 0.85,
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.025),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          // Circular avartar for the item pic
                          Column(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () => addItemController
                                      .selectItemImage(context),
                                  child: item.itemPic == null
                                      ? CircleAvatar(
                                          radius: screenSize.width * 0.03,
                                          // 40,
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
                                                  width: screenSize.width * 0.2,
                                                  // 200,
                                                  height:
                                                      screenSize.height * 0.2,
                                                  // 200,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : itemPic.value == null
                                          ? CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  FileImage(item.itemPic!
                                                      // itemPic.value!
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontSize: kBodyTextFont,
                                      ),
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
                                      hintText: item.itemName,
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
                                            style:
                                                textTheme.labelSmall?.copyWith(
                                              fontSize: kBodyTextFont,
                                            ),
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
                                                        //FIXME: add categotry function
                                                        debugPrint(
                                                            'Add Categroy tapped');

                                                        Get.to(() =>
                                                            const AddCategory());
                                                      },
                                                      child: Text(
                                                        truncateString(
                                                            'Add Category', 9),
                                                      ),
                                                    ),
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                fontSize: kBodyTextFont,
                                              ),
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
                                      hintText: item.itemCostPrice,
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
                                    hintText: item.itemSellingPrice,
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
                                              .labelSmall
                                              ?.copyWith(
                                                  fontSize: kBodyTextFont),
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
                          // stock available and track low stock
                          Row(
                            children: [
                              TextFeildWidget(
                                screenSize: screenSize,
                                isDarkMood: isDarkMood,
                                controller: addItemController.stockAvailable,
                                keyboardType: TextInputType.number,
                                hintText: item.itemQuantity,
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
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: kBodyTextFont,
                                          ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: kBodyTextFont),
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
                          Text(
                            kAddMoreImagesText,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: kBodyTextFont),
                          ),
                          Obx(() {
                            List<File> imagesToDisplay =
                                addItemController.moreImages.isEmpty
                                    ? item.morePics
                                    : addItemController.moreImages;

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
                                itemCount: imagesToDisplay.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index < imagesToDisplay.length) {
                                    File image = imagesToDisplay[index];
                                    return GestureDetector(
                                      onTap: () {
                                        addItemController.showDeleteImageAlert(
                                            context, isDarkMood, () {
                                          addItemController.removeImageInEdit(
                                              context, item, index);
                                        });
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
                                        addItemController.editImages(
                                            context, item);
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

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(kAddMoreImagesText),
                      //     Obx(() {
                      //       return SizedBox(
                      //         height: screenSize.height * 0.08,
                      //         width: double.infinity,
                      //         child: GridView.builder(
                      //           gridDelegate:
                      //               const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 5,
                      //             mainAxisSpacing: 4.0,
                      //             crossAxisSpacing: 8.0,
                      //           ),
                      //           itemCount: addItemController.moreImages.length + 1,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             if (index < addItemController.moreImages.length) {
                      //               File image =
                      //                   addItemController.moreImages[index];
                      //               return GestureDetector(
                      //                 onLongPress: () {
                      //                   print('Delete the image selected');
                      //                 },
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                   child: Container(
                      //                     height: screenSize.height * 0.07,
                      //                     width: screenSize.width * 0.15,
                      //                     decoration: BoxDecoration(
                      //                       borderRadius: BorderRadius.circular(10),
                      //                       border: Border.all(
                      //                         style: BorderStyle.solid,
                      //                         color: kGreyColor.withOpacity(0.3),
                      //                       ),
                      //                     ),
                      //                     child: Image.file(
                      //                       image,
                      //                       height: 50,
                      //                       width: 50,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               );
                      //             } else {
                      //               return GestureDetector(
                      //                 onTap: () {
                      //                   addItemController.addImage(context);
                      //                 },
                      //                 child: Container(
                      //                   height: screenSize.height * 0.07,
                      //                   width: screenSize.width * 0.15,
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(10),
                      //                     border: Border.all(
                      //                       style: BorderStyle.solid,
                      //                       color: kGreyColor.withOpacity(0.3),
                      //                     ),
                      //                   ),
                      //                   child: Icon(
                      //                     Icons.add,
                      //                     size: 30,
                      //                     color: kGreyColor.withOpacity(0.3),
                      //                   ),
                      //                 ),
                      //               );
                      //             }
                      //           },
                      //         ),
                      //       );
                      //     }),
                      //   ],
                      // ),

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
                              hintText: item.trackExpiry,
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
                              hintText: item.expiryAlert,
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
                            onPress: () {
                              int newStockAmount = int.parse(item.itemQuantity);

                              if (addItemController.stockAvailable.text
                                  .trim()
                                  .isNotEmpty) {
                                int additionalStock = int.tryParse(
                                        addItemController.stockAvailable.text
                                            .trim()) ??
                                    0;
                                newStockAmount += additionalStock;
                              }

                              AddItemModel updateItem = AddItemModel(
                                itemPic: addItemController.itemPic.value ??
                                    item.itemPic,
                                itemName: addItemController.itemName.text == ''
                                    ? item.itemName
                                    : addItemController.itemName.text.trim(),
                                itemSellingPrice:
                                    addItemController.sellingPrice.text == ''
                                        ? item.itemSellingPrice
                                        : addItemController.sellingPrice.text
                                            .trim(),
                                itemCategory:
                                    addCategoryController.categoryValue.value ==
                                            null
                                        ? item.itemCategory
                                        : addCategoryController
                                            .categoryValue.value?.categoryName,
                                itemQuantity: newStockAmount.toString(),
                                itemCostPrice:
                                    addItemController.costPrice.text == ''
                                        ? item.itemCostPrice
                                        : addItemController.costPrice.text
                                            .trim(),
                                trackProfit:
                                    addItemController.trackProfit.value == false
                                        ? item.trackProfit
                                        : addItemController.trackProfit.value,
                                trackLowStock:
                                    addItemController.trackLowStock.value ==
                                            false
                                        ? item.trackLowStock
                                        : addItemController.trackLowStock.value,
                                preventItemSalesWhenOutOfStock:
                                    addItemController
                                                .preventItemSalesWhenOutOfStock
                                                .value ==
                                            false
                                        ? item.preventItemSalesWhenOutOfStock
                                        : addItemController
                                            .preventItemSalesWhenOutOfStock
                                            .value,
                                trackExpiry:
                                    addItemController.trackExpiry.text == ''
                                        ? item.trackExpiry
                                        : addItemController.trackExpiry.text
                                            .trim(),
                                expiryAlert:
                                    addItemController.expiryAlert.text == ''
                                        ? item.expiryAlert
                                        : addItemController.expiryAlert.text
                                            .trim(),
                                itemCount: 0,
                                itemId: item.itemId,
                                morePics:
                                    addItemController.moreImages.isNotEmpty
                                        ? addItemController.moreImages
                                        : item.morePics,
                              );
                              AddItemController.instance
                                  .editItemOnPhone(updateItem);

                              // AddItemRepo.instance.editItemData(updateItem);
                            },
                            title: 'Update Item',
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
                ),
              ),
            ),
          ),
          Obx(
            () => addCategoryController.isLoading.value
                ? Positioned(
                    child: Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        )),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
