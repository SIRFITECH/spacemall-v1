import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/add_items.dart';
import 'package:spacemall/src/features/core_app/general/custom_button.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/custom_radio.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class AddStock extends StatelessWidget {
  const AddStock({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final textTheme = Theme.of(context).textTheme;

    final addItemController = Get.put(
      AddItemController(),
    );

    var itemPic = addItemController.itemPic;
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAddStockAppBarText),
        centerTitle: true,
        elevation: 0.5,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: kMainColorDark,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.025),
        child: ListView(
          children: [
            Row(
              children: [
                // Circular avartar for the item pic
                Column(
                  children: [
                    GestureDetector(
                        onTap: () =>
                            AddItemController.instance.selectItemImage(context),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              kMainComplimemtColorDark.withOpacity(0.2),
                          child: SizedBox(
                              child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: // check if the image placeholder is empty, get image from
                                  // sharedPreferences, otherwise, display the icon
                                  itemPic.value == null
                                      ? SvgPicture.asset(
                                          kImageIcon,
                                          color: kMainColorDark,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.scaleDown,
                                        )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundImage:
                                              FileImage(itemPic.value!),
                                        ),
                            ),
                          )),
                        )),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 6),
                                child: Text(
                                  kProductCategoryText,
                                  style: textTheme.labelSmall,
                                ),
                              ),
                              Obx(
                                () => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenSize.height * 0.024.toDouble()),
                                  height: screenSize.height * 0.04,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          // isDarkMood
                                          //     ? kTextFieldDarkColor
                                          //     : kWhiteDark,
                                          isDarkMood ? kWhiteDark : kBlackDark,
                                      // kTextFieldDarkBorderColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 0,
                                    ),
                                    iconSize: 32,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_circle,
                                      size: 10,
                                      color: kMainColorDark,
                                    ),
                                    value: addItemController.categoryValue
                                        .toString(),
                                    style: textTheme.labelSmall,
                                    elevation: 0,
                                    dropdownColor: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? kWhiteLight
                                        // kMainComplimemtColorLight
                                        //     .withOpacity(.4)
                                        : kBlackDark,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    items: addItemController.categoryItems
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: textTheme.labelSmall,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: addItemController.setCategory,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                padding: const EdgeInsets.only(top: 10.0),
                                child: CustomRadio(
                                  onChange: (bool? value) =>
                                      addItemController.setProfitTracking(),
                                  color: addItemController.trackProfit.value ==
                                          true
                                      ? kMainColorDark
                                      : kGreyColor,
                                  groupValue:
                                      addItemController.trackProfit.value,
                                  value: addItemController.trackProfit.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.025),
                              child: Text(
                                kTrackProfitText,
                                style: Theme.of(context).textTheme.labelSmall,
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
                      width: screenSize.width * 0.7,
                    ),
                    Column(
                      children: [
                        Obx(
                          () => CustomRadio(
                            onChange: (bool? value) =>
                                addItemController.setLowStockTracking(),
                            color: addItemController.trackLowStock.value == true
                                ? kMainColorDark
                                : kGreyColor,
                            groupValue: addItemController.trackLowStock.value,
                            value: addItemController.trackLowStock.value,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.025),
                          child: Text(
                            kTrackLowStockText,
                            style: Theme.of(context).textTheme.labelSmall,
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
                                    .preventItemSalesWhenOutOfStock.value ==
                                true
                            ? kMainColorDark
                            : kGreyColor,
                        groupValue: addItemController
                            .preventItemSalesWhenOutOfStock.value,
                        value: addItemController
                            .preventItemSalesWhenOutOfStock.value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.025),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AddItemsCard(items: addItemController.moreImages),
                ),
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
                  child: TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addItemController.trackExpiry,
                    keyboardType: TextInputType.datetime,
                    hintText: kDOBHintText,
                    labelText: kTrackExpiryDateText,
                    maxLines: 1,
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addItemController.expiryAlert,
                    keyboardType: TextInputType.datetime,
                    hintText: kDOBHintText,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  screenSize: screenSize,
                  onPress: () => AddItemRepo.instance
                      .saveItemData()
                      .then((value) => AddItemRepo.instance.clearControllers()),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kMainColorLight,
        child: const Icon(
          Icons.add,
          color: kWhiteDark,
        ),
      ),
    );
  }
}
