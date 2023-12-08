import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';

abstract class ReceiptRemoteDataBaseAdapter {
  Future<void> saveNewReceiptToDB({
    required ReceiptsModel newReceipt,
    required Function onSucess,
  });
}
