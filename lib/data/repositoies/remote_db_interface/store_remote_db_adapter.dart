import 'dart:io';

import '../../../src/features/core_app/store/domain/store_model.dart';

abstract class StoreRemoteDataBaseAdapter {
  Future<void> saveStoreToDB({
    required StoreModel newStore,
    required File logo,
    required Function onSucess,
  });
}
