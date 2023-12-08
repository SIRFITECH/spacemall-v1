import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

import '../domain/cart_model.dart';
import '../domain/check_out_item_model.dart';

class CartItemController extends GetxController {
  static CartItemController get instance => Get.put(CartItemController());

  // final CheckOutController checkOutController = Get.find();

  final profileConrtoller = Get.put(ProfileController());

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;

  RxInt tapedIndex = (-1).obs;
  RxInt items = 0.obs;
  RxInt cartQuantity = 0.obs;
  RxBool isFirstTime = true.obs;

  double discountRate = 0.1;
  double taxRate = 0.075;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  void setSale(String saleAmount) {
    SalesController.instance.salesForTheDay.value = saleAmount;
  }

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
          profilePicLocalPath: '',
          userName: '',
          email: '',
          contactNumber: '',
          country: '',
          bio: '',
          uid: '',
          role: '',
          cart: <CartItemModel>[],
          stores: RxList<StoreModel>([]),
          createdAt: '',
          profilePicRemotePath: '',
          storeUIDs: [],
        );
  }

  /// FOURTH LOGIC

  CartModel? getCartById(List<CartModel> carts, String cartId) {
    return carts.firstWhere(
      (cart) => cart.cartId == cartId,
      orElse: () => CartModel(
        cartId: cartId,
        // itemName: '',
        // quantityInCart: '',
        // totalItemPrice: '',
        // totalCartPrice: '',
        // numOfItemsInCart: '',
        // subTotal: '',
        // discount: '',
        // tax: '',
        cartItemList: [],
      ),
    );
  }

  increamentItems(int index, int tapedIndex) {
    if (index == tapedIndex) {
      setTapedIndex(index);
      update();
    }
  }

  setSelected(int index, int tapedIndex) {
    if (index == tapedIndex) {
      isSelected.value = true;
      update();
    }
  }
}
