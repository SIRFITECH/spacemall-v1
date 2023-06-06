import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.put(
        ProfileController(),
      );

  Rx<File?> profilePic = Rx(null);

  final List<CheckOutItemModel> cart = [];
  final String uid = '';
  final TextEditingController tFName = TextEditingController();
  final TextEditingController tLName = TextEditingController();
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tHomeAddress = TextEditingController();
  final TextEditingController tDOB = TextEditingController();
  final TextEditingController tContact = TextEditingController();
  final TextEditingController tWhatsApp = TextEditingController();
  final TextEditingController tState = TextEditingController();
  final TextEditingController tCity = TextEditingController();
  final TextEditingController tCountry = TextEditingController();
  final TextEditingController tZipCode = TextEditingController();
  final TextEditingController tBankName = TextEditingController();
  final TextEditingController tAccount = TextEditingController();
  final TextEditingController tBio = TextEditingController();
  final TextEditingController tJobTitle = TextEditingController();
  final TextEditingController tAlternativeEmail = TextEditingController();

  UserModel? user;

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
    profilePic = (await pickImage(context));
    update();
  }

  CheckOutItemModel? cartItem;

  updateUserData(Map<String, dynamic> data) {
    cartBox.put(cartItem!.itemName, data);
    // firebaseFirestore
    //     .collection(usersCollection)
    //     .doc(firebaseUser.value.uid)
    //     .update(data);
  }

  // Stream<UserModel> listenToUser() => firebaseFirestore
  //     .collection(usersCollection)
  //     .doc(firebaseUser.value.uid)
  //     .snapshots()
  //     .map((snapshot) => UserModel.fromSnapshot(snapshot));

  Future<void> createUser() async {}

  Future getUser() async {}
}
