import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/data/repositories/remote_db_interface/user_remote_db_adapter.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

import '../../../constants/colors.dart';
import '../../../features/auth/data/auth_repo/auth_repo.dart';
import '../../../features/core_app/profile/application/profile_controller.dart';
import '../../../utils/app_utils/appp_utils.dart';
import '../../../utils/helpers/helper.dart';

class UserFirebaseServices extends UserRemoteDataBaseAdapter {
  final _profileController = Get.put(
    ProfileController(),
  );
  final AuthRepo authRepo = Get.find();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String userId = '';

  @override
  saveUserToDB({
    required UserModel user,
    required File dp,
    required Function onSucess,
  }) async {
    try {
      _profileController.isLoading.value = true;
      userId = user.uid;

      if (userId != '') {
        await saveImageToDB('$userId/profilePic/${user.userName}', dp)
            .then((value) {
          user.profilePicLocalPath = _profileController.profilePicLocalPath;
          user.profilePicRemotePath = value;
          user.createdAt = DateFormat('d MMM, yyyy').format(DateTime.now());
          user.uid = userId;
        });
        _profileController.setUser(user);
        debugPrint('UID here is $userId');
        await _fireStore.collection('users').doc(userId).set(user.toMap()).then(
              (value) => onSucess(),
            );

        _profileController.isLoading.value = false;
      } else {
        _profileController.isLoading.value = false;

        spaceMallSnackBar(
          'You need to Login Again',
          'There was an error creating your profile, Please Login again',
          kWhiteLight,
          kRedColor,
        );

        Get.off(
          () => const Login(),
        );
        return;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('From saveUserToDB(), an error occured ${e.message}');
      spaceMallSnackBar(
          'Authentication Error', e.message.toString(), kWhiteLight, kRedColor);
    }
  }

  @override
  Future<void> deleteDataFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<void> getDataFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> getImageFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<List<Uint8List>> getImageListFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveImageDB(Uint8List imageBytes) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDataInDB() {
    throw UnimplementedError();
  }

//   String get userId => _userId;

//   set setUserId(String value) {
//     _userId = value;
//   }
}
