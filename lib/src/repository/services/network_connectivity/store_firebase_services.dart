import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spacemall/data/repositoies/remote_db_interface/store_remote_db_adapter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../utils/helpers/helper.dart';
import '../../hive_boxes.dart';

class StoreFirebaseServices extends StoreRemoteDataBaseAdapter {
  final _storeController = Get.put(
    StoreController(storeRepo: StoreRepo()),
  );
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final UserModel _user = userBox.get(
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
    ),
  );

  @override
  Future<void> saveStoreToDB({
    required StoreModel newStore,
    required File logo,
    required Function onSucess,
  }) async {
    try {
      saveImageToDB('${_user.uid}/storeLogos/${newStore.storeId}', logo)
          .then((value) {
        newStore.logoLocalPath = _storeController.logoPicLocalPath;
        newStore.logoRemotePath = value;
      });
      // set the newStore
      _storeController.setStore(newStore);

      await _fireStore
          .collection('stores')
          .doc(newStore.storeId)
          .set(newStore.toMap())
          .then((value) => onSucess());
    } catch (e) {
      debugPrint(
          'from the saveStoreToDB() in StoreFirebase, the error is: ${e.toString()}');
      spaceMallSnackBar(
        'Error Adding Store',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
