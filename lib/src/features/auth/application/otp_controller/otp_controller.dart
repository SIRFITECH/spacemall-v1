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
  String? phoneNo = LoginController.instance.phone.value;

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

  void verifyOTP(
    String otp,
  ) async {
    /// Note: if a user is verified, it means the user is logged in
    /// but if the user exists, it means the user has record in the db

    try {
      isLoading.value = true;
      var isVerified = await AuthRepo.instance.verifyOTP(
        otp,
      );
      // late bool
      var exists = AuthRepo.instance.profilePic.isNotEmpty;

      LoginController.instance.phoneController.clear();

      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //     exists = false;
      //     // Get.to(() => SetProfile());
      //   } else {
      //     print('User is signed in! uid is ${user.uid}');
      //     // DocumentSnapshot userDocument = await FirebaseFirestore.instance
      //     //     .collection('users')
      //     //     .doc(user.uid)
      //     //     .get();
      //     // UserModel? userData = UserModel.fromMap(
      //     //   userDocument.data() as Map<String, dynamic>,
      //     // );
      //     // print(userData.email);

      //     // Get.to(() => DashBoard());
      //     exists = true;
      //   }
      // });

      isVerified && exists
          ? {
              AuthRepo.instance.setSignedIn(),
              Get.offAll(
                () => DashBoard(),
              )
            }
          : Get.offAll(
              () => const SetProfile(),
            );

      // Get.offAll(
      //   () => StreamBuilder<User?>(
      //     stream: FirebaseAuth.instance.userChanges(),
      //     builder: (context, snapshot) {
      //       // if (snapshot.connectionState == ConnectionState.waiting) {
      //       //   // while waiting for app to fetch user data from firebase
      //       //   return Container(
      //       //     decoration: const BoxDecoration(color: kWhiteLight),
      //       //     child: const Center(
      //       //       child: CircularProgressIndicator(),
      //       //     ),
      //       //   );

      //       // } else if (snapshot.hasData && snapshot.data != null) {
      //       //   // if user exists and has data
      //       //   User? currentUser = snapshot.data;

      //       //   if (currentUser!.uid != '') {
      //       //     // Check if the user is actually logged in
      //       //     return FutureBuilder<DocumentSnapshot>(
      //       //       future: FirebaseFirestore.instance
      //       //           .collection('users')
      //       //           .doc(currentUser.uid)
      //       //           .get(),
      //       //       builder: (context, userSnapshot) {
      //       //         if (userSnapshot.connectionState ==
      //       //             ConnectionState.waiting) {
      //       //           return Container(
      //       //             decoration: const BoxDecoration(color: kWhiteLight),
      //       //             child: const Center(
      //       //               child: CircularProgressIndicator(),
      //       //             ),
      //       //           );
      //       //         } else if (userSnapshot.hasData &&
      //       //             userSnapshot.data != null) {
      //       //           DocumentSnapshot userDocument = userSnapshot.data!;
      //       //           UserModel? user = UserModel.fromMap(
      //       //             userDocument.data() as Map<String, dynamic>,
      //       //           );

      //       //           // var stores = FirebaseFirestore.instance
      //       //           //     .collection('stores')
      //       //           //     .doc('7JrocNKpZHX7B5RCsENydpGi36s2')
      //       //           //     .get();

      //       //           // StoreModel store = StoreModel.fromMap(
      //       //           //     stores as Map<String, dynamic>);

      //       //           userBox.put('user_profile', user);
      //       //           // print('Store is $store');

      //       //           return DashBoard();
      //       //         } else {
      //       //           return const SetProfile();
      //       //         }
      //       //       },
      //       //     );
      //       //   } else {
      //       //     // User not actually logged in
      //       //     return const Login();
      //       //   }
      //       // } else {
      //       //   print('does snapshot have data? ${snapshot.hasData}');
      //       //   print('is user logged in? ${snapshot.data != null} ');

      //       //   return DashBoard();
      //       // }

      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Container(
      //           decoration: const BoxDecoration(color: kWhiteLight),
      //           child: const Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         );
      //       } else {
      //         print('User is ${snapshot.data}');
      //         if (snapshot.hasData) {
      //           return Center(
      //             child: Text(snapshot.data!.uid),
      //           );
      //         } else {
      //           return const Center(
      //             child: Text('User not Logged in'),
      //           );
      //         }
      //       }
      //     },
      //   ),
      // );

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      AuthRepo.instance.catchLoginError(e);
    }
  }
}
