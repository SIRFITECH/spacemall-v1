import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';

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
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontSize: kBodyTextFont),
        ),
        Obx(
          () => RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Resend Code in ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: otpController.timer.value.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 14),
              ),
            ]),
          ),
        ),
        Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: otpController.timer.value < 1
                      ? () {
                        
                          AuthRepo.instance.resendOTP();
                        }
                      : null,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: kVResendNewCodeText,
                          style: otpController.timer.value > 1
                              ? Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: kHeaderTextFontSmall,
                                  )
                              : Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: TextButton(
            //     onPressed: () {
            //       otpController.setTimer();
            //       // Get.off(
            //       //   () => const Login(),
            //       // );
            //     },
            //     child: Text.rich(
            //       TextSpan(
            //         children: [
            //           TextSpan(
            //             text: 'Try Again',
            //             style: Theme.of(context).textTheme.headlineSmall,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
