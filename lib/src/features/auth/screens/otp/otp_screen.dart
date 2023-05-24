import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_footer.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_header_widget.dart';
import 'package:spacemall/src/features/auth/screens/otp/pinput_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final otpController = Get.put(OtpController());

    return Scaffold(
      backgroundColor: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
      body: SafeArea(
        child: ListView(
          children: [
            OTPHeader(screenSize: screenSize),
            // Pinput feild
            PinputWidget(otpController: otpController, isDarkMood: isDarkMood),
            // verify button
            OTPFooter(otpController: otpController)
          ],
        ),
      ),
    );
  }
}
