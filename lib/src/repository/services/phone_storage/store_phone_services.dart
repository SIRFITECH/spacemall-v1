import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacemall/data/repositoies/local_db_inteface/store_local_db_adapter.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../constants/colors.dart';
import '../../hive_boxes.dart';

class StorePhoneServices extends StoreLocalDataBaseAdapter {
  final _storeController = StoreController(storeRepo: StoreRepo());

  @override
  Future<void> saveStoreDataToDevice(StoreModel newStore) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    try {
      await storeBox.put(
        'store-${newStore.storeId}',
        newStore,
      );

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
