import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider(
      {super.key, required this.height, required this.thickness});
  final double height;
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDividerMargin),
      child: Divider(
        thickness: thickness,
        height: height,
      ),
    );

    // Expanded(
    //   child: Container(
    //     margin: const EdgeInsets.all(kDividerMargin),
    //     child: Divider(
    //       thickness: thickness,
    //       height: height,
    //     ),
    //   ),
    // );
  }
}
