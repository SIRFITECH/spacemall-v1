import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import '../../../../../../../constants/colors.dart';
import '../../../../../../../repository/services/network_connectivity/category_firebase_services.dart';
import '../../../../../../../repository/services/network_connectivity/network_connectivity.dart';
import '../../../../../../../repository/services/phone_storage/category_phone_sercives.dart';
import '../../../../../../../utils/app_utils/appp_utils.dart';

class AddCategoryRepo extends GetxController {
  static AddCategoryRepo get instance => Get.find();

  // save category to firebase and then save to phone afterwards
  // return error if user lost connection to internet
  saveCategory(BuildContext context, CategoryModel newCategory) async {
    bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();

    if (deviceHasInternet) {
      const Center(
        child: CircularProgressIndicator(),
      );
      try {
        CategoryFirebaseServices()
            .saveCategoryToDB(
          newCategory: newCategory,
          onSucess: () {
            CategoryPhoneServices().saveCategoryToDevice(newCategory);
          },
        )
            .then((value) {
          Get.to(() => Stock());

          spaceMallSnackBar(
            'Success!!',
            'You have added  ${newCategory.categoryName.toUpperCase()} to your store',
            kWhiteLight,
            kGreenColor,
          );
        });
      } catch (e) {
        debugPrint('error adding category ${e.toString()}');
      }
    } else {
      spaceMallSnackBar(
          'Add Store Error',
          'Seems you lost connection, please check you internet',
          kWhiteDark,
          kRedColor);
    }
  }

  removeCategory(int categoryIndex) {
    try {
      CategoryFirebaseServices()
          .deleteCategoryFromDB(categoryIndex)
          .then((value) {
        CategoryPhoneServices().deleteCategoryFromDevice(categoryIndex);
      });
    } catch (e) {
      debugPrint('Error deleting category ${e.toString()}');
      spaceMallSnackBar(
        'Error Deleting Category',
        'Could not remove category',
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
