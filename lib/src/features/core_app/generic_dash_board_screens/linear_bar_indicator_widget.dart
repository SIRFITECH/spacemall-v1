import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spacemall/src/constants/colors.dart';

class LinearBarIndicator extends StatelessWidget {
  const LinearBarIndicator({
    super.key,
    required this.isDarkMood,
    required this.percentage,
  });

  final bool isDarkMood;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            width: 2,
            color: kBrighComplementColor,
            strokeAlign: BorderSide.strokeAlignInside),
      ),
      child: LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        fillColor: kBrighComplementColor,
        animation: true,
        animateFromLastPercent: true,
        percent: percentage,
        progressColor: isDarkMood
            ? kMainComplimemtColorLight.withOpacity(.7)
            : kMainColorLight.withOpacity(.7),
        backgroundColor: isDarkMood
            ? kMainComplimemtColorLight.withOpacity(.4)
            : kMainColorLight.withOpacity(.4),
        lineHeight: 12,
        barRadius: const Radius.circular(10),
      ),
    );
  }
}
