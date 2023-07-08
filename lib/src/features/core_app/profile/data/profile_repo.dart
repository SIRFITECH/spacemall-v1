import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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

class ProfileRepo extends GetxController {
  static ProfileRepo get instance => Get.find();
  final AuthRepo authRepo = Get.find();

  final SplashController splashController = Get.find();
  final LoginController loginController = Get.find();

  final ProfileController profileController = Get.put(
    ProfileController(),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firestorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var dp =
      // profileController
      ProfileController.instance.profilePic.value;
  String? get currentUserId => _auth.currentUser?.uid;

  // bool isLoading = false;

  RxString conttactNumber = ''.obs;
  RxString role = ''.obs;

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
          cart: [],
          stores: [],
          profilePic: '',
          userName: profileController.tUserName.text.trim(),
          email: profileController.tEmail.text.trim(),
          contactNumber: '',
          country: loginController.country.value.flagEmoji,
          role: splashController.userRole.value,
          uid: AuthRepo.instance.uid,
          bio: profileController.tBio.text.trim(),
        );
  }

// store data
  saveData(BuildContext context) async {
    dp = profileController.profilePic.value;
    UserModel user = UserModel(
      profilePic: '',
      contactNumber: conttactNumber.value,
      role: splashController.userRole.value,
      cart: [],
      stores: [],
      uid: '',
      country: loginController.country.value.name,
      userName: profileController.tUserName.text.trim(),
      email: profileController.tEmail.text.trim(),
      bio: profileController.tBio.text.trim(),
    );
    print(
        'User role is ${splashController.userRole.value} and phone is ${loginController.phone.value}');
    if (profileController.profilePic.value!.path.isNotEmpty) {
      const Center(
        child: CircularProgressIndicator(),
      );
      ProfileRepo.instance.saveUserDataToFireBase(
        context: context,
        userModel: userModel,
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
      Get.snackbar(
        'Error',
        'You need to pick a profile photo',
        backgroundColor: kWhiteLight,
      );
    }
  }

  ///PHONE OPERATIONS

// save data to phone
  Future saveDataToPhone(UserModel user) async {
    // SharedPreferences localDrive = await SharedPreferences.getInstance();

    // await localDrive.setString(
    //   "user_model",
    //   jsonEncode(userModel.toMap()),
    // );

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

  // store file to storage

  Future<String> saveImageToStorage(String ref, File file) async {
    UploadTask uploadTask = _firestorage.ref().child(ref).putFile(file);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  // save data to firebase
  saveUserDataToFireBase({
    required BuildContext context,
    required UserModel userModel,
    required File dp,
    required Function onSucess,
  }) async {
    try {
      profileController.isLoading.value = true;
      await saveImageToStorage('profilePic/${authRepo.uid}', dp).then((value) {
        userModel.profilePic = value;
        userModel.uid = AuthRepo.instance.uid;
      });

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
}
