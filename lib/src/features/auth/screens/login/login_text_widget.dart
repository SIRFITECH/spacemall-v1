import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/sizes.dart';

import '../../../../constants/text_strings.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          kLoginText,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontSize: kHeaderTextFont),
        ),
        Text(
          kLoginSubTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontSize: kBodyTextFont),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
