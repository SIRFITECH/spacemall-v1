import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class ProfileRepo extends GetxController {
  static ProfileRepo get instance => Get.put(ProfileRepo());
  static ProfileController profileController = Get.put(
    ProfileController(),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firestorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final dp = profileController.profilePic.value;

  final uid = AuthRepo.instance.uid;
  // String get tAlternativeEmail => _tAlternativeEmail!;

  String? get currentUserId => _auth.currentUser?.uid;

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
            cart: [],
            profilePic: '',
            firstName: profileController.tFName.text.trim(),
            lastName: profileController.tLName.text.trim(),
            email: profileController.tEmail.text.trim(),
            gender: profileController.selectedGender.value,
            contactNumber: profileController.tContact.text.trim(),
            whatsappNumber: profileController.tWhatsApp.text.trim(),
            homeAddress: profileController.tHomeAddress.text.trim(),
            zipCode: profileController.tZipCode.text.trim(),
            state: profileController.tState.text.trim(),
            city: profileController.tCity.text.trim(),
            country: profileController.tCountry.text.trim(),
            bio: profileController.tBio.text.trim(),
            uid: uid);
  }

// store data
  saveData(BuildContext context) async {
    UserModel(
      cart: [],
      profilePic: '',
      firstName: profileController.tFName.text.trim(),
      lastName: profileController.tLName.text.trim(),
      email: profileController.tEmail.text.trim(),
      gender: profileController.selectedGender.value,
      contactNumber: profileController.tContact.text.trim(),
      whatsappNumber: profileController.tWhatsApp.text.trim(),
      homeAddress: profileController.tHomeAddress.text.trim(),
      zipCode: profileController.tZipCode.text.trim(),
      state: profileController.tState.text.trim(),
      city: profileController.tCity.text.trim(),
      country: profileController.tCountry.text.trim(),
      bio: profileController.tBio.text.trim(),
      uid: '',
    );
    if (dp == null) {
      const Center(
        child: CircularProgressIndicator(),
      );
      ProfileRepo.instance.saveUserDataToFireBase(
        context: context,
        userModel: userModel,
        dp: profileController.profilePic.value!,
        onSucess: () {
          // save to shared preference
          ProfileRepo.instance.saveDataToPhone().then(
                (value) => AuthRepo.instance.setSignedIn().then(
                  (value) {
                    Get.to(
                      DashBoard(),
                    );
                  },
                ),
              );
        },
      );
    } else {
      showSnackBar(
          context, 'Please add a profile pic ${profileController.profilePic}');
    }
  }

  ///PHONE OPERATIONS

// save data to phone
  Future saveDataToPhone() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();

    await localDrive.setString(
      "user_model",
      jsonEncode(userModel.toMap()),
    );
  }

// get data from phone
  Future<UserModel?> getProfileDataFromPhone() async {
    SharedPreferences localDrive = await SharedPreferences.getInstance();

    String? profileDataString = localDrive.getString("user_model");
    if (profileDataString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(profileDataString);
      return UserModel.fromMap(jsonMap);
    }

    return null;
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
      await saveImageToStorage('profilePic/$uid', dp).then((value) {
        userModel.profilePic = value;
        userModel.uid = AuthRepo.instance.uid;
      });

      _userModel = userModel;

      // save the data to firebase
      await _fireStore.collection('users').doc(uid).set(userModel.toMap()).then(
            (value) => onSucess(),
          );
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context,
        e.message.toString(),
      );
    }
  }
}
