import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(kDividerMargin),
        child: Divider(
          height: height,
        ),
      ),
    );
  }
}
