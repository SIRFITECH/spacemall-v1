import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  final SplashController splashController = Get.find();
  final AuthRepo authRepo = Get.find();

  var otp = ''.obs;
  RxBool isLoading = false.obs;

  void verifyOTP(String otp) async {
    /// Note: if a user is verified, it means the user is logged in
    /// but if the user exists, it means the user has record in the db
    isLoading.value = true;
    var isVerified = await AuthRepo.instance.verifyOTP(otp);
    var exists = AuthRepo.instance.profilePic.isNotEmpty;
    AuthRepo.instance.setSignedIn();
    isVerified && exists
        ? Get.offAll(() => DashBoard())
        : Get.offAll(() => const ChooseUserType());
    isLoading.value = false;
  }
}
