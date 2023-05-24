import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_screen.dart';

import '../../../../constants/text_strings.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kCoutryCodeHorizontal + 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Get.off(
              () => const OTPScreen(),
            );
          },
          child: const Text(kLoginText),
        ),
      ),
    );
  }
}
