import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spacemall/src/constants/colors.dart';

class DashBoardIcon extends StatelessWidget {
  const DashBoardIcon({
    super.key,
    required this.isDarkMood,
    required this.image,
    required this.title,
  });

  final bool isDarkMood;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: 50,
          // ignore: deprecated_member_use
          color: isDarkMood ? kDarkModeIconColor : kLightModeIconColor,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
        )
      ],
    );
  }
}
