import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.put(
        CartController(),
      );

  ProfileController profileController = Get.find();

  RxInt cartTotalPrice = 0.obs;

  void addItemToCart(CartItemModel newCartItem) {
    UserModel user = UserModel(
      profilePic: '',
      userName: '',
      email: '',
      contactNumber: '',
      country: '',
      bio: '',
      uid: '',
      role: '',
      cart: <CartItemModel>[],
      stores: <StoreModel>[],
    );

    user.cart.add(newCartItem);
  }
}
