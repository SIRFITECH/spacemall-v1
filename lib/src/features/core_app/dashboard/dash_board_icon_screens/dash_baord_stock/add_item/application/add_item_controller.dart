import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../../store/domain/store_model.dart';
import '../../add_category/domain/category_model.dart';

class AddItemController extends GetxController {
  static AddItemController get instance => Get.put(
        AddItemController(),
      );

  static AddItemRepo addItemRepo = Get.find();

  var isItemAdded = false.obs;

  var selectedIndex = 0.obs;

  RxBool isPressed = false.obs;
  RxInt numSelectedItems = 0.obs;

  // my initial variable
  RxList<AddItemModel> itemList = <AddItemModel>[].obs;

  void setPressed() {
    isPressed.value = true;
    update();
  }

  void increaementSelectedItem(int tapedIndex, int index) {
    if (tapedIndex == index
        // && isPressed.isTrue
        ) {
      AddItemController.instance.numSelectedItems.value++;
    }
  }

  void decreaementSelectedItem(int tapedIndex) {
    if (tapedIndex >= 0) {
      selectedIndex--;
    }
  }

  // final moreImages = <String>[
  //   "Image 1",
  //   "Image 2",
  //   "Image 3",
  //   "Image 4",
  // ];

  printItemList() {
    // print(itemList.length);
  }

  Rx<File?> itemPic = Rx(null);

  final RxBool trackProfit = false.obs;
  final RxBool trackLowStock = false.obs;
  final RxBool preventItemSalesWhenOutOfStock = false.obs;
  final TextEditingController itemName = TextEditingController();
  final TextEditingController costPrice = TextEditingController();
  final TextEditingController sellingPrice = TextEditingController();
  final TextEditingController stockAvailable = TextEditingController();
  final TextEditingController trackExpiry = TextEditingController();
  final TextEditingController expiryAlert = TextEditingController();

  void setProfitTracking() {
    trackProfit.value = !trackProfit.value;
    update();
  }

  void setLowStockTracking() {
    trackLowStock.value = !trackLowStock.value;

    update();
  }

  void setPreventItemSalesWhenOutOfStockTracking() {
    preventItemSalesWhenOutOfStock.value =
        !preventItemSalesWhenOutOfStock.value;
    update();
  }

  void selectItemImage(BuildContext context) async {
    itemPic.value = (await pickImage(context));
    update();
  }

  RxList<AddItemModel> convertStockItems(List stockFromDb) {
    List<AddItemModel> result = [];
    for (var item in stockFromDb) {
      result.add(AddItemModel.fromMap(item));
    }
    return result.obs; // Convert List to RxList
  }

// add item to phone memory
  Future<void> addItemToPhone() async {
    addItemRepo.saveItemData().then((value) => Get.off(() => Stock()));
  }

  RxList<File> moreImages = <File>[].obs;
  // add image to morepics
  void addImage(BuildContext context) async {
    File? pickedImage = await pickImage(context);
    if (pickedImage != null && moreImages.length < 5) {
      if (moreImages.length == 1) {
        moreImages.add(pickedImage);
        update();

        Get.snackbar(
          'Notice',
          'You can delete an image by long pressing on it',
          backgroundColor: kRedColor,
          colorText: kWhiteLight,
        );
      } else {
        moreImages.add(pickedImage);
        update();
      }
    } else if (pickedImage != null && moreImages.length == 4) {
      moreImages.add(pickedImage);
      update();
      Get.snackbar(
        'Limit Warning',
        'You can not add more than 5 images',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    } else {
      Get.snackbar(
        'Error',
        'You have exceeded the max images you can add',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

  // remove image from morepics
  void removeImage(BuildContext context, int index) async {
    if (index >= 0 && index < 5) {
      moreImages.remove(moreImages[index]);
      update();
    } else {
      Get.snackbar(
        'Error',
        'Image doesn\t exist',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

  // edit images in morepics
  void editImages(BuildContext context, AddItemModel item) async {
    List<File> existingImages = item.morePics;
    File? pickedImage = await pickImage(context);

    if (existingImages.length <= 4) {
      existingImages.add(pickedImage!);
      update();
    } else if (existingImages.length == 5) {
      Get.snackbar(
        'Limit Warning',
        'You can not add more than 5 images',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    } else {
      Get.snackbar(
        'Error',
        'No images were added',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

// show alert to delete image
  void showDeleteImageAlert(
      BuildContext context, isDarkMood, VoidCallback onPress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          contentTextStyle: TextStyle(
            color: isDarkMood ? null : kBlackDark,
          ),
          titleTextStyle: TextStyle(
            color: isDarkMood ? null : kBlackDark,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkMood ? kDarkModeBrightIconColor : null,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPress();
                // removeImage(context, index);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: isDarkMood ? kDarkModeBrightIconColor : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // remove image from edit morepics
  void removeImageInEdit(
      BuildContext context, AddItemModel item, int index) async {
    List<File> existingImages = item.morePics;

    if (index >= 0 && index < 5) {
      existingImages.remove(existingImages[index]);

      update();
    } else {
      Get.snackbar(
        'Error',
        'Image doesn\t exist',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

// clear images
  void clearImages() {
    moreImages.clear();
  }

  var selectedCategoryIndex = 0.obs;
  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
    update();
  }

  int allItemsInStore(StoreModel store) {
    int totalItems = 0;
    for (var category in store.categories) {
      totalItems += category.itemsInCategory.value;
      // int.tryParse();
    }
    return totalItems;
  }

  List<AddItemModel> filterItemsByCategory(
      int selectedCategoryIndex, List<CategoryModel> categories) {
    if (selectedCategoryIndex == -1) {
      List<AddItemModel> allItems = [];
      for (var category in categories) {
        allItems.addAll(category.items);
      }
      return allItems;
    } else if (selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < categories.length) {
      return categories[selectedCategoryIndex].items;
    } else {
      return [];
    }
  }
}
