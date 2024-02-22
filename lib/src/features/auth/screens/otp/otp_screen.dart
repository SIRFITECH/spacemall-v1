import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_footer.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_header_widget.dart';
import 'package:spacemall/src/features/auth/screens/otp/pinput_widget.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
      

    final OtpController otpController = Get.find();

    return Scaffold(
      backgroundColor: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
      appBar: MyAppBar(
        title: '',
        isDarkMood: isDarkMood,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            children: [
              OTPHeader(screenSize: screenSize),
              PinputWidget(
                  otpController: otpController, isDarkMood: isDarkMood),
              OTPFooter(otpController: otpController)
            ],
          ),
          Obx(
            () => otpController.isLoading.value
                ? Positioned(
                    child: Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        )),
                  )
                : Container(),
          )
        ],
      )),
    );
  }
}
