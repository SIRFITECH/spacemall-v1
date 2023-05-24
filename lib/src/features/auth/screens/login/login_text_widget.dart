import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          kLoginSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
