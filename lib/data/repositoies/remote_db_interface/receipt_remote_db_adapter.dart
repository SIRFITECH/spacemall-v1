import '../../../src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

abstract class ReceiptRemoteDataBaseAdapter {
  Future<void> saveNewSaleToDB({
    required SalesModel newSale,
    required Function onSucess,
  });
}
