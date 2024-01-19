import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../utils/themes/theme_widgets/text_theme.dart';
import '../../domain/on_boarding_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(kDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: screenSize.height * 0.4,
            image: AssetImage(
              model.image,
            ),
          ),
          Column(
            children: [
              Text(
                model.title,
                style: STextTheme.lightTextTheme.headlineMedium
                    ?.copyWith(fontSize: kHeaderTextFontSmall),
              ),
              Text(
                model.subTitle,
                style: STextTheme.lightTextTheme.labelMedium
                    ?.copyWith(fontSize: kBodyTextFont),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            model.counterText,
            style: STextTheme.lightTextTheme.headlineSmall
                ?.copyWith(fontSize: kHeaderTextFontSmall),
          ),
          const SizedBox(
            height: 95.0,
          )
        ],
      ),
    );
  }
}
