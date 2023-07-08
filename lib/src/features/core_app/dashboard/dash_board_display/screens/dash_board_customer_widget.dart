import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/application/dash_baord_controller.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/linear_bar_indicator_widget.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

class DashBoardCustomerWidget extends StatelessWidget {
  DashBoardCustomerWidget({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  final dashBoardController = DashBoardController();
  final StoreRepo storeRepo = Get.find();

  //   final storeRepo = StoreRepo();
  // final storeController = StoreController(storeRepo: storeRepo);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    var stores = StoreController.instance.stores;
    final storeController = StoreController(storeRepo: storeRepo);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$kCustomersOfTheDayText / $kLastHighestCustomerText',
              style: textTheme.titleMedium,
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
                const SizedBox(
                  width: 5,
                ),
                Text(
                  kCustomerCommentText,
                  style: textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 40,
          width: screenSize.width * 0.4,
          decoration: BoxDecoration(
            border: const Border(bottom: BorderSide.none),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Center(
                child: Obx(
              () => DropdownButton<StoreModel>(
                iconSize: 32,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: kBrighComplementColor,
                ),
                value:
                    // stores.isNotEmpty
                    //     ? stores.first
                    //     :
                    storeController.selectedStore.value,
                elevation: 0,
                dropdownColor: !isDarkMood
                    ? kMainComplimemtColorLight.withOpacity(.4)
                    : kBlackDark,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                items: stores
                    .map<DropdownMenuItem<StoreModel>>((StoreModel value) {
                  return DropdownMenuItem<StoreModel>(
                    value: value,
                    child: Text(
                      value.storeName,
                      style: textTheme.titleSmall,
                    ),
                  );
                }).toList(),
                onChanged: (StoreModel? newValue) =>
                    storeController.setStore(newValue),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
