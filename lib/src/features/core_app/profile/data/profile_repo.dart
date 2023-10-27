import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../repository/services/network_connectivity/network_connectivity.dart';
import '../../../../repository/services/network_connectivity/user_firebase_services.dart';
import '../../../../repository/services/phone_storage/user_phone_services.dart';
import '../../dashboard/dash_board_display/screens/dash_board_screen.dart';
import '../../store/domain/store_model.dart';

class ProfileRepo extends GetxController {
  static ProfileRepo get instance => Get.find();
  final AuthRepo authRepo = Get.find();

  final SplashController splashController = Get.find();
  final LoginController loginController = Get.find();

  final _profileController = Get.put(
    ProfileController(),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var dp = ProfileController.instance.profilePic.value;

  String? get currentUserId => _auth.currentUser?.uid;

  RxString role = ''.obs;

  saveUser(BuildContext context) async {
    _profileController.isLoading.value = true;
    bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();

    if (deviceHasInternet) {
      dp = _profileController.profilePic.value;
      UserModel user = UserModel(
        profilePicLocalPath: '',
        contactNumber: ProfileController.instance.contactNumber ?? '',
        role: splashController.userRole.value,
        cart: [],
        stores: RxList<StoreModel>()..addAll([]),
        uid: AuthRepo.instance.uid,
        country: loginController.country.value.name,
        userName: _profileController.tUserName.text.trim(),
        email: _profileController.tEmail.text.trim(),
        bio: _profileController.tBio.text.trim(),
        createdAt: DateFormat('d MMM, yyyy').format(DateTime.now()),
        profilePicRemotePath: '',
      );
      const Center(
        child: CircularProgressIndicator(),
      );
      if (_profileController.profilePic.value != null) {
        try {
          bool internetAvailable =
              await NetworkConnectivity().deviceHasInternet();

          if (internetAvailable == true) {
            UserFirebaseServices()
                .saveUserToDB(
                  user: user,
                  dp: dp!,
                  onSucess: () {
                    UserPhoneServices().saveUserDataToDevice(user).then(
                          (value) => AuthRepo.instance.setSignedIn().then(
                            (value) {
                              Get.offAll(
                                DashBoard(),
                              );
                            },
                          ),
                        );
                  },
                )
                .then(
                  (value) => spaceMallSnackBar(
                    'Success!!',
                    'You have created a profile with the username ${user.userName.toUpperCase()}',
                    kWhiteLight,
                    kGreenColor,
                  ),
                );
          } else {
            spaceMallSnackBar(
              'Error Creating Profile',
              'You can not create profile offline, \n check your internet connection and try again',
              kWhiteLight,
              kRedColor,
            );
          }
        } catch (e) {
          debugPrint('There is error adding user: ${e.toString()}');
        }
      } else {
        Get.snackbar('Profile photo needed', 'You have to add a profile photo',
            backgroundColor: kRedColor, colorText: kWhiteLight);
      }
    } else {
      spaceMallSnackBar(
          'Save User Error',
          'Seems you lost connection, please check you internet',
          kWhiteDark,
          kRedColor);
    }
  }

// fetch saved data from phone storage

  Future<void> deleteLastItemFromPhone() async {
    if (userBox.isNotEmpty) {
      userBox.deleteFromDisk();
      update();
    }
  }

  Rx<ThemeMode> themeMood = ThemeMode.system.obs;
}
