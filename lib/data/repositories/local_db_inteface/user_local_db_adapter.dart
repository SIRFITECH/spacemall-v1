import 'dart:io';

import 'package:flutter/services.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

abstract class UserLocalDataBaseAdapter {
  Future<void> saveImageToDevice(File? image);
  Future<void> saveImageListToDevice(Uint8List imageBytes);
  Future<Uint8List> getImageFromDevice();
  Future<List<Uint8List>> getImageListToDevice();
  Future<void> saveUserDataToDevice(UserModel user);
  Future<void> getDataFromDevice();
  Future<void> updateDataInDevice();
  Future<void> deleteDataFromDevice();
}
