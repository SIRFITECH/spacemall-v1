import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/data/repositories/local_db_inteface/store_local_db_adapter.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../constants/colors.dart';
import '../../hive_boxes.dart';

class StorePhoneServices extends StoreLocalDataBaseAdapter {
  final _storeController = StoreController(storeRepo: StoreRepo());
  final ProfileController _profileController = Get.find();

  @override
  Future<void> saveStoreDataToDevice(StoreModel newStore) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    try {
      final UserModel user = userBox.get(
        'user_profile',
        defaultValue: UserModel(
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
          storeUIDs: [],
        ),
      );
      // Add the new store UID to the user's list of storeUIDs
      user.storeUIDs.add(newStore.storeId);

      // Save the updated user data to local storage
      await userBox.put('user_profile', user);

      await storeBox.put(
        'store-${newStore.storeId}',
        newStore,
      );

      _profileController.setUser(user);
      _storeController.stores.add(newStore);
    } catch (e) {
      debugPrint(
          'Error occured in the saveStoreDataToDevice() in StorePhoneServices ${e.toString()}');
      spaceMallSnackBar(
          'Error creating ${_storeController.storeName.text.trim()} store',
          e.toString(),
          kWhiteLight,
          kRedColor);
    }
  }
}
