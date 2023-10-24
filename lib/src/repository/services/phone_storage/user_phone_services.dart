import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/data/repositoies/local_db_inteface/user_local_db_adapter.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../constants/colors.dart';
import '../../../features/core_app/profile/application/profile_controller.dart';
import '../../hive_boxes.dart';

class UserPhoneServices extends UserLocalDataBaseAdapter {
  final _profileController = ProfileController();

  @override
  Future<void> saveUserDataToDevice(UserModel user) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    await userBox.put('user_profile', user);

    Get.snackbar(
      'User created',
      'User with username ${_profileController.tUserName.text.toUpperCase()} created successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
  }

  @override
  Future<void> saveImageListToDevice(Uint8List imageBytes) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveImageToDevice(image) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    throw UnimplementedError();
  }

  Future<String> saveProfilePicToDevice() async {
    String profilePic = '';

    return profilePic;
  }

  @override
  Future<void> deleteDataFromDevice() {
    throw UnimplementedError();
  }

  Future<UserModel> getUserDataFromPhone() async {
    try {
      UserModel user = await userBox.get('user_profile', defaultValue: null);
      _profileController.setUser(user);
      return user;
    } catch (e) {
      spaceMallSnackBar('Error', 'Error getting user data from Hive: $e',
          kWhiteLight, kRedColor);
      return UserModel(
        cart: [],
        stores: RxList([]),
        profilePicLocalPath: '',
        bio: '',
        createdAt: '',
        email: '',
        contactNumber: '',
        country: '',
        role: '',
        uid: '',
        userName: '',
        profilePicRemotePath: '',
      ); // Replace with an appropriate default user model.
    }
  }

  @override
  Future<void> getDataFromDevice() async {
    UserModel user;
    try {
      user = await userBox.get('user_profile', defaultValue: null);
      _profileController.setUser(user);
    } catch (e) {
      spaceMallSnackBar('Error', "There was an error getting user from phone",
          kWhiteLight, kRedColor);
    }
  }

  ImageProvider<Object> chooseImageProvider(
      bool isConnected, String localImagePath, String networkImageUrl) {
    if (isConnected) {
      print(
          'from the chooseImageProvider(), networkImageUrl is $networkImageUrl');
      return NetworkImage(networkImageUrl);
    } else {
      print(
          'from the chooseImageProvider(), localImagePath is $localImagePath');
      return FileImage(File(localImagePath));
    }
  }

  @override
  Future<Uint8List> getImageFromDevice() {
    throw UnimplementedError();
  }

  @override
  Future<List<Uint8List>> getImageListToDevice() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDataInDevice() {
    throw UnimplementedError();
  }
}
