import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_tag/application/add_tag_controller.dart';

bool _isLoading = false;
bool get isLoading => _isLoading;

final AddTagController addTagController = Get.find();
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

Future<File?> pickImage(BuildContext context) async {
  try {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      return File(selectedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return null;
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
void dialogBox(
  bool isDarkMood,
  String title,
  String content,
  dynamic page,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.defaultDialog(
      backgroundColor: !isDarkMood
          ? kDarkModeBackgroundColor.withOpacity(0.1)
          : kWhiteDark.withOpacity(0.1),
      title: title,
      titleStyle: const TextStyle(
        color: kWhiteLight,
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: kWhiteLight,
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (page == null) {
            Get.back();
          }
          Get.offAll(
            page,
          );
        },
        child: const Text(kOkayText),
      ),
    );
  });
}
