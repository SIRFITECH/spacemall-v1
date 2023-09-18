import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';

class OTPFooter extends StatelessWidget {
  const OTPFooter({
    super.key,
    required this.otpController,
  });

  final OtpController otpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kVerifyButtonHorizontal,
              vertical: kVerifyButtonVertical),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                OtpController.instance.verifyOTP(otpController.otp.value);
              },
              child: const Text(kVerifyOTPButtonText),
            ),
          ),
        ),
        Text(
          kVDidntReciveCodeText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: kVResendNewCodeText,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  Get.off(
                    () => const Login(),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Try Again',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
