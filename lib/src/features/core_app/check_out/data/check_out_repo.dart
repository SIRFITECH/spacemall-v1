import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../repository/hive_boxes.dart';
import '../domain/check_out_item_model.dart';

class CheckOutRepo extends GetxController {
  static CheckOutRepo get instance => Get.put(
        CheckOutRepo(),
      );

  String itemId = const Uuid().v4();

  // get stores
  List<CartItemModel> getCheckOutCartFromBox() {
    List<CartItemModel> checkOutCart = [];
    for (var key in storeBox.keys) {
      if (key.startsWith('store-')) {
        CartItemModel? cart = cartBox.get(key);
        if (cart != null) {
          checkOutCart.add(cart);
        }
      }
    }
    return checkOutCart;
  }

  //   // get stores
  // List<StoreModel> getStoresFromBox() {
  //   List<StoreModel> stores = [];
  //   for (var key in storeBox.keys) {
  //     if (key.startsWith('store-')) {
  //       StoreModel? store = storeBox.get(key);
  //       if (store != null) {
  //         stores.add(store);
  //       }
  //     }
  //   }
  //   return stores;
  // }
}
