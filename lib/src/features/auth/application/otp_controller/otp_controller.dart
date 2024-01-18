import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  final SplashController splashController = Get.find();
  final AuthRepo authRepo = Get.find();

  final ProfileController _profileController = Get.find();

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
        spaceMallSnackBar(
          'Request resend',
          'You can request OTP resend now',
          kWhiteLight,
          kGreyColor,
        );
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
      // check if user is authenticated
      // var isVerified =
      await AuthRepo.instance.verifyOTP(
        otp,
      );
      // // check if user has a profile existing
      // var exists = AuthRepo.instance.user.userName != '';

      LoginController.instance.phoneController.clear();

      // UserModel user = AuthRepo.instance.user;
      // isVerified && exists
      //     ? {
      //         print(user.storeUIDs),
      //         // AuthRepo.instance.user.storeUIDs

      //         AuthRepo.instance.setSignedIn(),
      //         Get.offAll(
      //           () => DashBoard(),
      //         )
      //       }
      //     : Get.offAll(() => const AuthCheckScreen()
      //         //  OnBoarding(),
      //         );

      Get.offAll(
        () => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            setUserStore(UserModel user) async {
              await Hive.openBox<StoreModel>('store');
              List<StoreModel> userStores = [];

              for (var uid in user.storeUIDs) {
                var store = await FirebaseFirestore.instance
                    .collection('stores')
                    .doc(uid)
                    .get();

                if (store.exists) {
                  StoreModel myStore =
                      StoreModel.fromMap(store.data() as Map<String, dynamic>);

                  userStores.add(myStore);
                  await storeBox.put(
                    'store-$uid',
                    myStore,
                  );
                }

                user.stores.value = userStores;
              }

              _profileController.setUser(user);
              await userBox.put('user_profile', user);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              // while waiting for app to fetch user data from firebase
              return Container(
                decoration: const BoxDecoration(color: kWhiteLight),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.uid != '') {
              User? currentUser = snapshot.data;

              if (currentUser!.uid != '') {
                // Check if the user is actually logged in
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser.uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        decoration: const BoxDecoration(color: kWhiteLight),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (userSnapshot.hasData &&
                        userSnapshot.data != null) {
                      // if the user exists but have already created a profile
                      bool userAlreadyExists = false;
                      try {
                        if (userSnapshot.data!.get('userName') != '') {
                          userAlreadyExists = true;
                        }
                      } catch (e) {
                        debugPrint('User is new : ${e.toString()}');
                        userAlreadyExists = false;
                      }

                      if (userAlreadyExists) {
                        DocumentSnapshot userDocument = userSnapshot.data!;

                        UserModel? user = UserModel.fromMap(
                          userDocument.data() as Map<String, dynamic>,
                        );
                        setUserStore(user);

                        return DashBoard();
                      } else {
                        // if the user exists but has not created a profile yet
                        return const SetProfile();
                      }
                    } else {
                      // if the user is a new user with no profile yet
                      return const SetProfile();
                    }
                  },
                );
              } else {
                // User not actually logged in

                return DashBoard();
              }
            } else {
              debugPrint('user  does not exist');
              return const Login();
            }
          },
        ),
      );

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      AuthRepo.instance.catchLoginError(e);
    }
  }
}

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
