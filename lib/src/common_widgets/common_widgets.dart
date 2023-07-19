import 'package:flutter/material.dart';

import '../constants/colors.dart';

class clickableText extends StatelessWidget {
  const clickableText({
    super.key,
    required this.isDarkMood,
    required this.text,
  });

  final bool isDarkMood;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: !isDarkMood ? kMainColorLight : kMainComplimemtColorLight,
      ),
    );
  }
}
