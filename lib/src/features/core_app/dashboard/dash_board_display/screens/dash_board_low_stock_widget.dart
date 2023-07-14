import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/remaining_stock_report.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/linear_bar_indicator_widget.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';
import 'package:spacemall/src/features/core_app/mall/screens/mall_screen.dart';

class DashBaordLowStockWidget extends StatelessWidget {
  const DashBaordLowStockWidget({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => const RemainingStock(),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$kStockAvailbaleText of $kTotalStockText',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              LinearBarIndicator(
                isDarkMood: isDarkMood,
                percentage: kLowStockLinearBarIndicator,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Iconz(
                    isDarkMood: isDarkMood,
                    image: kStockIcon,
                    color: isDarkMood ? kWhiteDark : kBrighComplementColor,
                    height: kLinearBarIconzHeight,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    kStockCommentText,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const MallScreen());
          },
          child: Column(
            children: [
              Iconz(
                isDarkMood: isDarkMood,
                image: kMallIcon,
                height: kMallIconzHeight,
                color: isDarkMood ? kWhiteDark : kBrighComplementColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                kMallText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
