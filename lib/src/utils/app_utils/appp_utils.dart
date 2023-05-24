import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacemall/src/constants/colors.dart';

bool _isLoading = false;
bool get isLoading => _isLoading;

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.04,
      top: MediaQuery.of(context).size.height * 0.02,
      left: MediaQuery.of(context).size.height * 0.01,
      right: MediaQuery.of(context).size.height * 0.01,
    ),
    content: Text(content),
    backgroundColor: kMainColorDark,
  ));
}

Future<Rx<File?>> pickImage(BuildContext context) async {
  Rx<File?> dp = Rx(null);

  try {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      dp.value = File(selectedImage.path);
    }
  } catch (e) {
    // show a snachbar with the error message
    showSnackBar(context, e.toString());
  }
  return dp;
}

// // using the string type
// Future<String?> downloadImage(String imageUrl) async {
//   try {
//     final ref = FirebaseStorage.instance.ref().child(imageUrl);
//     final data = await ref.getData();
//     final base64Data = base64.encode(data!);
//     return base64Data;
//   } catch (e) {
//     // Handle the error, such as logging it or displaying a message to the user
//     return null;
//   }
// }
