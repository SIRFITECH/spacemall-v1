import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/application/dash_baord_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_report.dart';
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final storeController = StoreController(storeRepo: storeRepo);

    List<StoreModel> storesFromBox = storeRepo.getStoresFromBox();

    return Row(
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
        ),
        SizedBox(
          width: screenSize.width * 0.26,
        ),
        Center(
          child: Obx(
            () => DropdownButton<StoreModel>(
              iconSize: 32,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kBrighComplementColor,
              ),
              value: storeController.selectedStore.value,
              elevation: 0,
              dropdownColor: kTransparentColor,
              // !isDarkMood
              //     ? kMainComplimemtColorLight.withOpacity(.4)
              //     : kBlackDark,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              items: storesFromBox
                  .map<DropdownMenuItem<StoreModel>>((StoreModel value) {
                    return DropdownMenuItem<StoreModel>(
                      value: value,
                      child: Text(
                        value.storeName,
                        style: textTheme.titleSmall,
                      ),
                    );
                  })
                  .toSet()
                  .toList(),
              onChanged: (StoreModel? newValue) =>
                  storeController.setStore(newValue),
            ),
          ),
        ),
        // Container(
        //   height: 40,
        //   width: screenSize.width * 0.3,
        //   decoration: BoxDecoration(
        //     border: const Border(bottom: BorderSide.none),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Center(
        //     child: Obx(
        //       () => DropdownButton<StoreModel>(
        //         iconSize: 32,
        //         icon: const Icon(
        //           Icons.arrow_drop_down,
        //           color: kBrighComplementColor,
        //         ),
        //         value: storeController.selectedStore.value,
        //         elevation: 0,
        //         dropdownColor: !isDarkMood
        //             ? kMainComplimemtColorLight.withOpacity(.4)
        //             : kBlackDark,
        //         borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         items: storesFromBox
        //             .map<DropdownMenuItem<StoreModel>>((StoreModel value) {
        //               return DropdownMenuItem<StoreModel>(
        //                 value: value,
        //                 child: Text(
        //                   value.storeName,
        //                   style: textTheme.titleSmall,
        //                 ),
        //               );
        //             })
        //             .toSet()
        //             .toList(),
        //         onChanged: (StoreModel? newValue) =>
        //             storeController.setStore(newValue),
        //       ),
        //     ),
        //   ),
        // ),

        SizedBox(
          width: screenSize.width * 0.005,
        ),
        Iconz(
          isDarkMood: isDarkMood,
          image: kMallIcon,
          height: kMallIconzHeight,
          color: isDarkMood ? kWhiteDark : kBrighComplementColor,
        ),
      ],
    );
  }
}
