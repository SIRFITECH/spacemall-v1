import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    final addItemController = Get.put(AddItemController());
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
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                padding: const EdgeInsets.only(top: 80),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: stockItemBox.length,
                itemBuilder: (context, index) {
                  AddItemModel stockItem = stockItemBox.getAt(index);
                  return GestureDetector(
                      onTap: () {
                        // variable to hold the state of the card, whetehr pressed or not

                        // varaible to track item taped
                        var tapIndex = index;
                        if (index == tapIndex) {
                          // set the selected value to true
                          addItemController.setPressed();
                          addItemController.increaementSelectedItem(tapIndex);

                          AddItemModel selectedStockItem =
                              stockItemBox.getAt(tapIndex);
                          // print(selectedStockItem.itemName);
                          print(addItemController.isPressed.value);
                          debugPrint('$tapIndex');
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                              width: 100,
                              height: 60,
                              child: stockItem.itemPic == null
                                  ? SvgPicture.asset(
                                      kImageIcon,
                                      color: kMainColorDark,
                                      width: 50,
                                      height: 70,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(stockItem.itemPic!))),
                          Text(
                            stockItem.itemName,
                          ),
                          Text(
                            'N${stockItem.itemSellingPrice}',
                          ),
                        ],
                      ));
                })),
      ),
    );
  }
}
