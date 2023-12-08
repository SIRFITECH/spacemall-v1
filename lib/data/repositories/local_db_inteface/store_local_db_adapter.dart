import '../../../src/features/core_app/store/domain/store_model.dart';

abstract class StoreLocalDataBaseAdapter {
  Future<void> saveStoreDataToDevice(StoreModel newStore);
}
