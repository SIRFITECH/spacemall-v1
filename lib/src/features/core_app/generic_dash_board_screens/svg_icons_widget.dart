// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Iconz extends StatelessWidget {
  const Iconz({
    super.key,
    required this.isDarkMood,
    required this.image,
    required this.color,
    required this.height,
  });

  final bool isDarkMood;
  final String image;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            height: height,
            color: color,
          ),
        ],
      ),
    );
  }
}
