import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../utils/helpers/helper.dart';
import '../../store/domain/store_model.dart';

class ProfileRepo extends GetxController {
  static ProfileRepo get instance => Get.find();
  final AuthRepo authRepo = Get.find();

  final SplashController splashController = Get.find();
  final LoginController loginController = Get.find();

  final ProfileController profileController = Get.put(
    ProfileController(),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseStorage _firestorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var dp = ProfileController.instance.profilePic.value;
  String? get currentUserId => _auth.currentUser?.uid;

  // bool isLoading = false;

  // RxString conttactNumber = ''.obs;
  RxString role = ''.obs;

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
          cart: [],
          stores: RxList([]),
          profilePic: '',
          bio: profileController.tBio.text.trim(),
          createdAt: '',
          email: '',
          contactNumber: '',
          country: '',
          role: '',
          uid: '',
          userName: profileController.tUserName.text.trim(),
        );
  }

// store data
  saveData(BuildContext context) async {
    dp = profileController.profilePic.value;
    UserModel user = UserModel(
      profilePic: '',
      contactNumber: ProfileController.instance.contactNumber ?? '',
      role: splashController.userRole.value,
      cart: [],
      stores: RxList<StoreModel>()..addAll([]),
      uid: AuthRepo.instance.uid,
      country: loginController.country.value.name,
      userName: profileController.tUserName.text.trim(),
      email: profileController.tEmail.text.trim(),
      bio: profileController.tBio.text.trim(),
      createdAt: DateFormat('d MMM, yyyy').format(DateTime.now()),
    );

    const Center(
      child: CircularProgressIndicator(),
    );
    if (profileController.profilePic.value != null) {
      ProfileRepo.instance.saveUserDataToFireBase(
        context: context,
        userModel: user,
        dp: profileController.profilePic.value!,
        onSucess: () {
          // save to phone memory
          ProfileRepo.instance.saveDataToPhone(user).then(
                (value) => AuthRepo.instance.setSignedIn().then(
                  (value) {
                    Get.offAll(
                      DashBoard(),
                    );
                  },
                ),
              );
        },
      );
    } else {
      Get.snackbar('Profile photo needed', 'You have to add a profile photo',
          backgroundColor: kRedColor, colorText: kWhiteLight);
    }
  }

  ///PHONE OPERATIONS

  final user = {
    'name': 'John',
    'age': 30,
  };
  createUser(user) {
    return user;
  }

// save data to phone
  Future saveDataToPhone(UserModel user) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    await userBox.put('user_profile', user);

    Get.snackbar(
      'User created',
      'User with username ${profileController.tUserName.text.toUpperCase()} created successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
  }

  void clearFeilds() {
    profileController.profilePic = Rx(null);
    profileController.tUserName.clear();
    profileController.tEmail.clear();
    profileController.tBio.clear();
  }

// fetch saved data from phone storage
  Future<UserModel> getUserDataFromPhone() async {
    UserModel user = await userBox.get('user_profile', defaultValue: null);
    return user;
  }

  Future<void> deleteLastItemFromPhone() async {
    if (userBox.isNotEmpty) {
      userBox.deleteFromDisk();
      update();
    }
  }

  ///DATABASE OPERATIONS
  // save data to firebase
  saveUserDataToFireBase({
    required BuildContext context,
    required UserModel userModel,
    required File dp,
    required Function onSucess,
  }) async {
    profileController.isLoading.value = true;
    try {
      await saveImageToStorage('profilePic/${authRepo.uid}', dp).then(
        (value) {
          userModel.profilePic = value;
          userModel.createdAt =
              DateFormat('d MMM, yyyy').format(DateTime.now());
          // userModel.contactNumber = AuthRepo.instance.userPhone ?? '';
          userModel.uid = AuthRepo.instance.uid;
        },
      );

      _userModel = userModel;

      // save the data to firebase
      await _fireStore
          .collection('users')
          .doc(authRepo.uid)
          .set(userModel.toMap())
          .then(
            (value) => onSucess(),
          );
      profileController.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context,
        e.message.toString(),
      );
    }
  }

  Rx<ThemeMode> themeMood = ThemeMode.system.obs;
  // IconButton(
  //          onPressed: () {
  //            if (Get.isDarkMode) {
  //              themeController.changeTheme(Themes.lightTheme);
  //              themeController.saveTheme(false);
  //            } else {
  //              themeController.changeTheme(Themes.darkTheme);
  //              themeController.saveTheme(true); }},
  //          icon: Get.isDarkMode
  //              ? const Icon(Icons.light_mode_outlined)
  //              : const Icon(Icons.dark_mode_outlined),)
  void toggleThemeMode() {
    // themeMood.value == ThemeMode.dark
    //     ? SAppTheme.darkTheme
    //     : SAppTheme.lightTheme;
    // update();
    // print('Theme mood is theme.system');
    // print(themeMood.value);
  }
}
