import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:uuid/uuid.dart';

class CheckOutRepo extends GetxController {
  static CheckOutRepo get instance => Get.put(
        CheckOutRepo(),
      );

  ProfileController profileController = Get.find();
  String itemId = const Uuid().v4();

  // CheckOutModel? _checkOutModel;
  // CheckOutModel get checkOutModel {
  //   return _checkOutModel ??
  //       CheckOutModel(itemId: itemId, itemPic: itemPic, itemName: itemName, itemQuantity: itemQuantity, price: price, totalPrice: totalPrice,)
  // }

  // void addProductToCart(AddItemModel item) {
  //   try {
  //     // check if item is already added
  //     if (isItemAlreadyAdded(item)) {
  //       Get.snackbar(
  //           'Check your cart', '${item.itemName} is already added to cart');
  //     } else {

  //       profileController.updateUserData(_checkOutModel)
  //     }
  //   } catch (e) {}
  //   ;
  // }
}
