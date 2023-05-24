import 'package:flutter/material.dart';
import 'package:spacemall/src/features/auth/screens/login/login_divider_widget.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginOr extends StatelessWidget {
  const LoginOr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kFormHeight - 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoginDivider(
            height: kDividerHeight,
          ),
          Text(
            kDividerText.toUpperCase(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const LoginDivider(
            height: kDividerHeight,
          ),
        ],
      ),
    );
  }
}
