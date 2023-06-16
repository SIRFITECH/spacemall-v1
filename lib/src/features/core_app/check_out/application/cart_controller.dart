import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.put(
        CartController(),
      );

  ProfileController profileController = Get.find();

  RxInt cartTotalPrice = 0.obs;

  void addItemToCart(CheckOutItemModel newCartItem) {
    UserModel user = UserModel(
      profilePic: '',
      firstName: '',
      lastName: '',
      email: '',
      gender: '',
      contactNumber: '',
      whatsappNumber: '',
      homeAddress: '',
      zipCode: '',
      state: '',
      city: '',
      country: '',
      bio: '',
      uid: '',
      role: '',
      cart: <CheckOutItemModel>[],
    );
    user.cart.add(newCartItem);
  }
}
