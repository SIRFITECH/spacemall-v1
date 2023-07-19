import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/domain/stock_model.dart';

class StockController extends GetxController {
  static StockController get instance => Get.find();
  // SalesController salesController = Get.put(SalesController());

  final items = <String>[
    "ADD ITEM",
    "ADD CATEGORY",
    "ADD TAG",
    "ADD MODIFIER",
  ];
  RxList<StockModel> stockList = RxList<StockModel>([]);

  void addStock(StockModel object) {
    stockList.add(object);
  }

  void removeStock(StockModel object) {
    stockList.remove(object);
  }

  List<StockModel> convertStockItems(List stockFromDb) {
    List<StockModel> result = [];
    for (var item in stockFromDb) {
      StockModel.fromMap(item);
    }
    return result;
  }
}
