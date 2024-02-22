import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';

abstract class SalesRemoteDataBaseAdapter {
  Future<void> saveNewSalesToDB({
    required SalesModel newSales,
    required Function onSucess,
  });
}
