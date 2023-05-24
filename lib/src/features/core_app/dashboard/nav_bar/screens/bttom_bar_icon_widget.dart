import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/svg_icons_widget.dart';

class BottomBarIcon extends StatelessWidget {
  final String text;
  final String icon;
  final bool selected;
  final Function() onPress;

  const BottomBarIcon({
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final darkMood = isDarkMood ? kWhiteDark : kBrighComplementColor;
    final lightMood = isDarkMood ? kSecondary2Color : kMainComplimemtColorLight;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
      ),
      child: Container(
        margin: bottomNavIconSpace,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: onPress,
                child: Iconz(
                  isDarkMood: isDarkMood,
                  image: icon,
                  color: selected ? lightMood : darkMood,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  height: 0.1,
                  color: selected ? lightMood : darkMood,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
