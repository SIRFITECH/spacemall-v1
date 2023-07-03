import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  // static ProfileController get instance => Get.put(
  //       ProfileController(),
  //     );
  //TODO: You can change profilePic as the commented lins below
// File profilePic = File('');
// Rx<File> profilePic = Rx(File(''));
  RxBool isLoading = false.obs;
  Rx<File?> profilePic = Rx(null);
  RxList<CartItemModel> cart = <CartItemModel>[].obs;
  RxList<StoreModel> stores = <StoreModel>[].obs;
  final String uid = '';
  final TextEditingController tUserName = TextEditingController();
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tBio = TextEditingController();

  UserModel? user;

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

  // gender select end here

  void selectImage(BuildContext context) async {
    profilePic = (await pickImage(context));
    update();
  }

  CartItemModel? cartItem;

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
}
