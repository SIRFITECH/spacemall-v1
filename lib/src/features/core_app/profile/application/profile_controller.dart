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

  RxBool isLoading = false.obs;
  Rx<File?> profilePic = Rx(
      null); // i want to make profile icon to be default pic if user does not have dp

  RxList<CartItemModel> cart = <CartItemModel>[].obs;
  RxList<StoreModel> stores = <StoreModel>[].obs;
  final String uid = '';
  final TextEditingController tUserName = TextEditingController();
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tBio = TextEditingController();
  TextEditingController? tContactNumber = TextEditingController();
  final TextEditingController tTrial = TextEditingController();
  String? contactNumber = '';

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
    profilePic.value = (await pickImage(context));
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
// first one, throws error that is corrected in second one
// Future<void> loadProfilePicture() async {
//   try {
//     // Fetch and load the user's profile picture
//     await user!.fetchProfilePicture();
//   } on HttpException catch (e) {
//     // Handle HttpException (Connection reset by peer)
//     print('HttpException caught: $e');
//     // You can show an error message or retry the request here
//   } catch (e) {
//     // Handle other exceptions
//     print('Exception caught: $e');
//   }
// }
// second one, throws error that is yet to be corrected
// Future<void> loadProfilePicture() async {
//   try {
//     // Fetch and load the user's profile picture
//     await NetworkImage(user!.profilePic).resolve( const ImageConfiguration()).addListener(
//       ImageStreamListener((info, call) {
//         // Image loaded successfully
//         // You can perform any necessary actions here
//       }),
//     );
//   } on HttpException catch (e) {
//     // Handle HttpException (Connection reset by peer)
//     print('HttpException caught: $e');
//     // You can show an error message or retry the request here
//   } catch (e) {
//     // Handle other exceptions
//     print('Exception caught: $e');
//   }
// }

  // Stream<UserModel> listenToUser() => firebaseFirestore
  //     .collection(usersCollection)
  //     .doc(firebaseUser.value.uid)
  //     .snapshots()
  //     .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
