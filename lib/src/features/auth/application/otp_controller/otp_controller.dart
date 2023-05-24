import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  var otp = ''.obs;

  void verifyOTP(String otp) async {
    /// Note: if a user is verified, it means the user is logged in
    /// but if the user exists, it means the user has record in the db
    var isVerified = await AuthRepo.instance.verifyOTP(otp);
    var exists = AuthRepo.instance.profilePic.isNotEmpty;
    AuthRepo.instance.setSignedIn();
    isVerified && exists
        ? Get.offAll(() => DashBoard())
        : Get.offAll(() => const SetProfile());
  }
}
