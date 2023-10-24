import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../constants/colors.dart';
import '../../../../repository/hive_boxes.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  RxBool _isLoading = false.obs;

  UserModel? _user;

  bool _isConnected = true;

  String _profilePicRemotePath = '';
  String _profilePicLocalPath = '';

  Rx<File?> profilePic = Rx(null);
  RxList<CartItemModel> cart = <CartItemModel>[].obs;
  RxList<StoreModel> stores = <StoreModel>[].obs;
  final String uid = '';
  final TextEditingController tUserName = TextEditingController();
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tBio = TextEditingController();
  TextEditingController? tContactNumber = TextEditingController();
  final TextEditingController tTrial = TextEditingController();
  String? contactNumber = '';

// for gender select
  final List<String> genders = [
    'Male',
    'Female',
  ].obs;

  final RxList<bool> isSelected = [
    true,
    false,
  ].obs;

  Rx<String> selectedGender = ''.obs;

  void selectImage(BuildContext context) async {
    profilePic.value = (await pickImage(context));
    setProfilePicLocalPath(profilePic.value!.path);
    update();
  }

  Future<UserModel?> getUserDataFromHive() async {
    try {
      UserModel user = await userBox.get('user_profile', defaultValue: null);
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
      );
    }
  }

  RxBool get isLoading => _isLoading;
  void setIsLoading(RxBool value) {
    _isLoading = value;
  }

  UserModel? get user => _user;

  void setUser(UserModel? value) {
    _user = value;
  }

  bool get isConnected => _isConnected;

  void setIsConnected(bool value) {
    _isConnected = value;
  }

  String get profilePicRemotePath => _profilePicRemotePath;

  void setProfilePicRemotePath(String value) {
    _profilePicRemotePath = value;
  }

  String get profilePicLocalPath => _profilePicLocalPath;

  void setProfilePicLocalPath(String value) {
    _profilePicLocalPath = value;
  }
}
