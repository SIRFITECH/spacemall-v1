import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';

// class PinputWidget extends StatelessWidget {
//   const PinputWidget({
//     super.key,
//     required this.isDarkMood,
//   });

//   final bool isDarkMood;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(kVerifyOTPSubText),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: kDefaultSize,
//             vertical: kDefaultSize,
//           ),
//           child: Pinput(
//             onCompleted: (value) {},
//             length: 6,
//             showCursor: true,
//             defaultPinTheme: PinTheme(
//               height: kPinputThemeHeight,
//               width: kPinputThemeWidth,
//               decoration: isDarkMood
//                   ? BoxDecoration(
//                       borderRadius: BorderRadius.circular(kPinputBorderRadius),
//                       border: Border.all(color: kMainComplimemtColorLight),
//                     )
//                   : BoxDecoration(
//                       borderRadius: BorderRadius.circular(kPinputBorderRadius),
//                       border: Border.all(color: kMainColorLight),
//                     ),
//               textStyle: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class PinputWidget extends StatelessWidget {
  const PinputWidget({
    super.key,
    required this.otpController,
    required this.isDarkMood,
  });

  final OtpController otpController;
  final bool isDarkMood;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(
          left: kDefaultSize,
        ),
        child: Text(
          kVerifyOTPSubText,
          style: TextStyle(fontSize: 11),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultSize,
          vertical: kDefaultSize,
        ),
        child: Pinput(
          onCompleted: (value) {
            otpController.otp.value = value;
            OtpController.instance.verifyOTP(otpController.otp.value);
          },
          length: 6,
          showCursor: true,
          defaultPinTheme: PinTheme(
            height: kPinputThemeHeight,
            width: kPinputThemeWidth,
            decoration: isDarkMood
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(kPinputBorderRadius),
                    border: Border.all(color: kMainComplimemtColorLight),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(kPinputBorderRadius),
                    border: Border.all(color: kMainColorLight),
                  ),
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    ]);
  }
}
