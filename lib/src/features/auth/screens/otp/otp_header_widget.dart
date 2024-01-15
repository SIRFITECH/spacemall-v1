import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';

class OTPHeader extends StatelessWidget {
  const OTPHeader({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          height: screenSize.height * 0.5,
          image: const AssetImage(kOTPIllustration),
        ),
        Text(
          kVerifyOTPText,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontSize: kHeaderTextFont),
        )
      ],
    );
  }
}
