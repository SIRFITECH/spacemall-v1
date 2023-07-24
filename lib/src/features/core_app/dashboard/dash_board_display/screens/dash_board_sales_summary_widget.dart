import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';

class DashBoardSalesSummary extends StatelessWidget {
  const DashBoardSalesSummary({
    super.key,
    required this.isDarkMood,
  });

  final bool isDarkMood;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.25,
        horizontal: screenSize.width * 0.2,
      ),
      child: Positioned(
        top: 2,
        child: Container(
            height: screenSize.height * 0.085,
            width: screenSize.width * 0.8,
            decoration: BoxDecoration(
              color: isDarkMood ? kLightThemeBgColor : kLightThemeBgColor,
              border: Border.all(
                width: 2,
                color: isDarkMood ? kDarkModeIconColor : kMainColorLight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                    color: kBlackDark,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.013),
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Iconz(
                        image: kCalenderIcon,
                        color:
                            isDarkMood ? kDarkModeIconColor : kMainColorLight,
                        height: 40,
                        isDarkMood: isDarkMood,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: kBlackDark,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'N $kTodaySalesValueText',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          kTodaySalesText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: kBlackDark,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
