import '../../../src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';

abstract class StockRemoteDataBaseAdapter {
  Future<void> saveStockItemToDB({
    required AddItemModel stockItem,
    required Function onSucess,
  });
  Future<void> editStockInFirebase(AddItemModel editedItem);

  Future<void> deleteStockFromFirebase(AddItemModel deleteItem);
}
