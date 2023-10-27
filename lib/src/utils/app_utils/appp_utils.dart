import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_tag/application/add_tag_controller.dart';

bool _isLoading = false;
bool get isLoading => _isLoading;

final AddTagController addTagController = Get.find();
// void showSnackBar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     padding: EdgeInsets.only(
//       bottom: MediaQuery.of(context).size.height * 0.04,
//       top: MediaQuery.of(context).size.height * 0.02,
//       left: MediaQuery.of(context).size.height * 0.01,
//       right: MediaQuery.of(context).size.height * 0.01,
//     ),
//     content: Text(content),
//     backgroundColor: kMainColorDark,
//   ));
// }

SnackbarController spaceMallSnackBar(
    String title, String message, Color? textColor, Color? bgColor) {
  return Get.snackbar(title, message,
      colorText: textColor, backgroundColor: bgColor);
}

Future<File?> pickImage(BuildContext context) async {
  try {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      return File(selectedImage.path);
    }
  } catch (e) {
    spaceMallSnackBar('Error ', e.toString(), kWhiteLight, kRedColor);
  }
  return null;
}

Future<Uint8List> fileToUint8List(File file) async {
  try {
    final Uint8List uint8list = await file.readAsBytes();
    return uint8list;
  } catch (e) {
    debugPrint('Error converting File to Uint8List: $e');
    return Uint8List(0);
  }
}

Future<List<File>> pickMultipleImages(BuildContext context) async {
  List<File> selectedImages = [];

  try {
    final pickedImages = await ImagePicker().pickMultiImage();

    // ignore: unnecessary_null_comparison
    if (pickedImages != null) {
      selectedImages = pickedImages.map((pickedImage) {
        return File(pickedImage.path);
      }).toList();
    }
  } catch (e) {
    spaceMallSnackBar('Error ', e.toString(), kWhiteLight, kRedColor);
  }

  return selectedImages;
}

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
