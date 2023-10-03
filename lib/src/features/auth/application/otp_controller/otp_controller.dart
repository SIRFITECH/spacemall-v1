import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  final SplashController splashController = Get.find();
  final AuthRepo authRepo = Get.find();

  var otp = ''.obs;
  var resendToken = RxInt(0);
  RxBool isLoading = false.obs;
  RxInt timer = RxInt(30);

  void setTimer() {
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (time) {
      if (timer.value == 0) {
        time.cancel();
        Get.snackbar('Request resend', 'You can request OTP resend now');
      } else {
        timer.value--;
      }
    });
  }

  void verifyOTP(String otp) async {
    /// Note: if a user is verified, it means the user is logged in
    /// but if the user exists, it means the user has record in the db

    try {
      isLoading.value = true;
      var isVerified = await AuthRepo.instance.verifyOTP(otp);
      var exists = AuthRepo.instance.profilePic.isNotEmpty;
      AuthRepo.instance.setSignedIn();
      LoginController.instance.phoneController.clear();
      isVerified && exists
          ? Get.offAll(
              () => DashBoard(),
            )
          : Get.offAll(
              () => const SetProfile(),
            );
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      AuthRepo.instance.catchLoginError(e);
    }
  }
}
