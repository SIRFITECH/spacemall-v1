import 'dart:io';

import 'package:flutter/services.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

abstract class UserRemoteDataBaseAdapter {
  Future<void> saveUserToDB({
    required UserModel user,
    required File dp,
    required Function onSucess,
  });
  Future<void> saveImageDB(Uint8List imageBytes);
  Future<Uint8List> getImageFromDB();
  Future<List<Uint8List>> getImageListFromDB();

  Future<void> getDataFromDB();
  Future<void> updateDataInDB();
  Future<void> deleteDataFromDB();
}
