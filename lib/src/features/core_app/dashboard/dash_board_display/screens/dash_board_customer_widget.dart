import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_report.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/linear_bar_indicator_widget.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../../../../utils/helpers/helper.dart';

class DashBoardCustomerWidget extends StatelessWidget {
  DashBoardCustomerWidget({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  final StoreRepo storeRepo = Get.find();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    // ignore: unused_local_variable
    // final dashBoardController = DashBoardController(context);

    if (StoreRepo.instance.getStoresFromBox().isNotEmpty) {
      for (var store in StoreRepo.instance.getStoresFromBox()) {
        debugPrint(store.storeName);
      }
    }

    final storeController = StoreController(storeRepo: storeRepo);

    if (storeBox.isNotEmpty && storeController.selectedStore.value == null) {
      storeController.setStore(
        StoreRepo.instance.getStoresFromBox().first,
      );
    } else {
      storeController.setStore(
        StoreController.instance.selectedStore.value,
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: screenSize.width * 0.000003),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => const TopCustomerReport(),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$kCustomersOfTheDayText / $kLastHighestCustomerText',
                  style:
                      textTheme.titleMedium?.copyWith(fontSize: kBodyTextFont),
                ),
                LinearBarIndicator(
                  isDarkMood: isDarkMood,
                  percentage: kCustomerLinearBarIndicator,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Iconz(
                      isDarkMood: isDarkMood,
                      image: kCustomerIcon,
                      color: isDarkMood ? kWhiteDark : kBrighComplementColor,
                      height: kLinearBarIconzHeight,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.005,
                    ),
                    Text(
                      kCustomerCommentText,
                      style: textTheme.titleSmall
                          ?.copyWith(fontSize: kBodyTextFont),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.20,
          ),
          Obx(() => Center(
                child: DropdownButton<StoreModel>(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: kBrighComplementColor,
                  ),
                  value: storeController.selectedStore.value,
                  hint: Text(
                    kAddNewStoreText,
                    style: TextStyle(
                      color: isDarkMood ? kWhiteDark : kWhiteLight,
                      fontSize: kBodyTextFont,
                    ),
                  ),
                  elevation: 0,
                  dropdownColor: !isDarkMood
                      ? kMainComplimemtColorLight.withOpacity(.4)
                      : kBlackDark,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  items: StoreRepo.instance
                      .getStoresFromBox()
                      .map<DropdownMenuItem<StoreModel>>((StoreModel value) {
                        return DropdownMenuItem<StoreModel>(
                          value: value,
                          child: Text(
                            truncateString(
                              value.storeName,
                              12,
                            ),
                            style: textTheme.titleSmall,
                          ),
                        );
                      })
                      .toSet()
                      .toList(),
                  onChanged: (StoreModel? newValue) => storeController.setStore(
                    newValue,
                  ),
                ),
              )),
          SizedBox(
            width: screenSize.width * 0.005,
          ),
          Iconz(
            isDarkMood: isDarkMood,
            image: kStoreIcon,
            height: kMallIconzHeight,
            color: isDarkMood ? kWhiteDark : kBrighComplementColor,
          ),
        ],
      ),
    );
  }
}
