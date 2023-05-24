import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/application/dash_baord_controller.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/linear_bar_indicator_widget.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';

class DashBoardCustomerWidget extends StatefulWidget {
  const DashBoardCustomerWidget({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  @override
  State<DashBoardCustomerWidget> createState() =>
      _DashBoardCustomerWidgetState();
}

class _DashBoardCustomerWidgetState extends State<DashBoardCustomerWidget> {
  final dashBoardController = DashBoardController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              isDarkMood: widget.isDarkMood,
              percentage: kCustomerLinearBarIndicator,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Iconz(
                  isDarkMood: widget.isDarkMood,
                  image: kCustomerIcon,
                  color: widget.isDarkMood ? kWhiteDark : kBrighComplementColor,
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
          width: 110,
          decoration: BoxDecoration(
            // color: MediaQuery.of(context).platformBrightness == Brightness.light
            //     ? kMainComplimemtColorLight.withOpacity(.4)
            //     : kBrighComplementColor,
            // // kBlackDark,
            // // kMainColorLight.withOpacity(.4),
            border: const Border(bottom: BorderSide.none),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Center(
                child: Obx(
              () => DropdownButton<String>(
                iconSize: 32,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: kBrighComplementColor,
                ),
                value: dashBoardController.dropdownValue.toString(),
                elevation: 0,
                dropdownColor: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? kMainComplimemtColorLight.withOpacity(.4)
                    : kBlackDark,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                items: dashBoardController.items
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: textTheme.titleSmall,
                    ),
                  );
                }).toList(),
                onChanged: dashBoardController.setStore,
              ),
            )),
          ),
        ),
      ],
    );
  }
}
