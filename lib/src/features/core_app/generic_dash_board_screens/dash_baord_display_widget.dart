import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';

class DashBaordDisplay extends StatelessWidget {
  const DashBaordDisplay({
    super.key,
    required this.screenSize,
    required this.isDarkMood,
    required this.media,
  });

  final Size screenSize;
  final bool isDarkMood;
  final MediaQueryData media;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height * 0.3),
      child: SizedBox(
          height: screenSize.height * 0.75,
          child: Container(
            color: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
            child: Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.06),
              child: Column(
                children: [
                  Iconz(
                    isDarkMood: isDarkMood,
                    image: kStockIcon,
                    height: kMallIconzHeight,
                    color:
                        isDarkMood ? kMainComplimemtColorLight : kMainColorDark,
                  ),
                  SizedBox(
                    height: media.size.height * 0.005,
                  ),
                  Text(
                    kDashbaordStockText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
