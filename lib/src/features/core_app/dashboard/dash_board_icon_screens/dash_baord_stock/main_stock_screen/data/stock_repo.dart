import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/constants/image_strings.dart';

class StoreRepo extends GetxController {
  static StoreRepo get instance => Get.find();
  // Map<String, dynamic> stockMap = jsonDecode();
  // var stockItem = jsonEncode(
  //   StockModel(
  //     itemPic,
  //     itemName,
  //     itemPrice,
  //     itemCategory,
  //     itemQuantity,
  //   ),
  // );

  void saveToPhone() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    localStorage.setString('name', kStockIcon);
  }

  void getFromPhone() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    localStorage.getString('name');
  }
}
