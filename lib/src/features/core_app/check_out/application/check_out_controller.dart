import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

class CheckOutItemController extends GetxController {
  static CheckOutItemController get instance => Get.put(
        CheckOutItemController(),
      );
  final profileRepo = Get.put(ProfileRepo());

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;
  RxInt totalCartPrice = 0.obs;

  RxInt tapedIndex = (-1).obs;
  RxInt items = RxInt(1);
  // 1.obs;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  RxList<CheckOutItemModel> cartItems = <CheckOutItemModel>[].obs;

  removeItemFromCart(
    int index,
  ) {
    cartItems.removeAt(index);
  }

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
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
  }

  /// TODO: FIRST LOGIC

  // addToCart(
  //   CheckOutItemModel newItem,
  //   int index,
  //   BuildContext context,
  // ) async {
  //   String id = cartItems.length > index ? cartItems[index].itemId : '';
  //   if (itemExistInCart(newItem, id)) {
  //     num quantity = int.parse(cartItems[index].quantityInCart) + 1;
  //     cartItems[index].quantityInCart = quantity.toString();
  //     String priceString = (cartItems[index].price);
  //     String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
  //     String quantityInCartString = (cartItems[index].quantityInCart);
  //     String numQuantityInCartString =
  //         quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
  //     num initCost =
  //         int.parse(numQuantityInCartString) * int.parse(numPriceString);
  //     num cost = initCost;

  //     cartItems[index].subTotal = cost.toString();
  //     print(
  //         '${newItem.itemName} with id $id already exists ane new cost is ${cartItems[index].subTotal}');
  //     print(' Item quantity is ${cartItems[index].quantityInCart}');
  //     Get.snackbar(
  //       '1 more ${cartItems[index].itemName} add to cart',
  //       'If you want to delete ${cartItems[index].itemName} from cart just presse and hold',
  //       backgroundColor: kWhiteLight,
  //     );
  //   } else {
  //     UserModel? user;
  //     if (_userModel == null) {
  //       user = await profileRepo.getUserDataFromPhone();
  //       user.cart.add(newItem);
  //       cartItems.value = user.cart;

  //       print('${newItem.itemName} is added');

  //       Get.snackbar(
  //         'Operation Successfull',
  //         'Item added to cart succeffully',
  //         backgroundColor: kWhiteLight,
  //         colorText: kBlack,
  //       );
  //     } else {
  //       user = _userModel;
  //       user!.cart.add(newItem);
  //       cartItems.value = user.cart;
  //     }
  //   }
  // }

  // bool itemExistInCart(CheckOutItemModel newItem, String id) {
  //   for (CheckOutItemModel item in cartItems) {
  //     if (item.itemId == id) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  /// TODO: SECOND LOGIC
  // addToCart(
  //   CheckOutItemModel newItem,
  //   int index,
  //   BuildContext context,
  // ) async {
  //   String id = cartItems.length > index ? cartItems[index].itemId : '';
  //   if (!itemExistInCart(newItem)) {
  //     UserModel? user;
  //     if (_userModel == null) {
  //       user = await profileRepo.getUserDataFromPhone();

  //       user.cart.add(newItem);
  //       cartItems.value = user.cart;

  //       print('${newItem.itemName} is added');
  //       Get.snackbar(
  //         'Operation Successful',
  //         'Item added to cart succeffuly',
  //         backgroundColor: kWhiteLight,
  //         colorText: kBlack,
  //       );
  //     } else {
  //       user = _userModel;
  //       user!.cart.add(newItem);
  //       cartItems.value = user.cart;
  //       // print('User cart has ${user.cart.length} items');
  //       // print(
  //       //     'the item id of the new item is ${newItem.itemId}, id of the pressed item $id');
  //     }
  //   } else {
  //     num quantity = int.parse(cartItems[index].quantityInCart) + 1;
  //     cartItems[index].quantityInCart = quantity.toString();
  //     String priceString = (cartItems[index].price);
  //     String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
  //     String quantityInCartString = (cartItems[index].quantityInCart);
  //     String numQuantityInCartString =
  //         quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
  //     num initCost =
  //         int.parse(numQuantityInCartString) * int.parse(numPriceString);
  //     num cost = initCost;

  //     cartItems[index].subTotal = cost.toString();
  //     print(
  //         '${newItem.itemName} with id $id already exists ane new cost is ${cartItems[index].subTotal}');
  //     print(' Item quantity is ${cartItems[index].quantityInCart}');
  //     Get.snackbar(
  //       '1 more ${cartItems[index].itemName} add to cart',
  //       'If you want to delete ${cartItems[index].itemName} from cart just presse and hold',
  //       backgroundColor: kWhiteLight,
  //     );
  //   }
  // }

  // bool itemExistInCart(CheckOutItemModel newItem) {
  //   for (CheckOutItemModel item in cartItems) {
  //     if (item.itemId == newItem.itemId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  /// TODO: THIRD LOGIC

  // addToCart(
  //   CheckOutItemModel newItem,
  //   int index,
  //   BuildContext context,
  // ) async {
  //   String id = cartItems.length > index ? cartItems[index].itemId : '';

  //   if (!itemExistInCart(newItem)) {
  //     // Item does not exist in cart, add it
  //     UserModel? user;
  //     if (_userModel == null) {
  //       user = await profileRepo.getUserDataFromPhone();
  //     } else {
  //       user = _userModel;
  //     }

  //     user!.cart.add(newItem);
  //     cartItems.value = user.cart;

  //     print('${newItem.itemName} is added for the first time');

  //     Get.snackbar(
  //       'Operation Successful',
  //       'Item added to cart successfully',
  //       backgroundColor: kWhiteLight,
  //       colorText: kBlack,
  //     );
  //   } else {
  //     // Item already exists in cart, update quantity and subtotal
  //     if (index >= 0 && index < cartItems.length) {
  //       num quantity = int.parse(cartItems[index].quantityInCart) + 1;
  //       cartItems[index].quantityInCart = quantity.toString();
  //       String priceString = (cartItems[index].price);
  //       String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
  //       String quantityInCartString = (cartItems[index].quantityInCart);
  //       String numQuantityInCartString =
  //           quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
  //       num initCost =
  //           int.parse(numQuantityInCartString) * int.parse(numPriceString);
  //       num cost = initCost;

  //       cartItems[index].subTotal = cost.toString();

  //       print(
  //           '${newItem.itemName} with id $id already exists and new cost is ${cartItems[index].subTotal}');
  //       print('Item quantity is ${cartItems[index].quantityInCart}');
  //       Get.snackbar(
  //         '1 more ${cartItems[index].itemName} add to cart',
  //         'If you want to delete ${cartItems[index].itemName} from cart just press and hold',
  //         backgroundColor: kWhiteLight,
  //       );
  //     } else {
  //       print('Invalid index');
  //     }
  //   }
  // }

  // bool itemExistInCart(CheckOutItemModel newItem) {
  //   for (CheckOutItemModel item in cartItems) {
  //     if (item.itemId == newItem.itemId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  /// TODO: FOURTH LOGIC

  void addToCart(
    CheckOutItemModel newItem,
    BuildContext context,
  ) async {
    if (!itemExistInCart(newItem)) {
      // Item does not exist in cart, add it
      UserModel? user;
      if (_userModel == null) {
        user = await profileRepo.getUserDataFromPhone();
      } else {
        user = _userModel;
      }

      user!.cart.add(newItem);
      cartItems.value = user.cart;

      print('${newItem.itemName} is added for the first time');

      Get.snackbar(
        'Operation Successful',
        'Item added to cart successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      // Item already exists in cart, update quantity and subtotal
      CheckOutItemModel existingItem = cartItems.firstWhere(
        (item) => item.itemId == newItem.itemId,
      );

      if (existingItem.itemId.isNotEmpty) {
        num quantity = int.parse(existingItem.quantityInCart) + 1;
        existingItem.quantityInCart = quantity.toString();
        String priceString = existingItem.price;
        String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
        String quantityInCartString = existingItem.quantityInCart;
        String numQuantityInCartString =
            quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
        num initCost =
            int.parse(numQuantityInCartString) * int.parse(numPriceString);
        num cost = initCost;

        existingItem.subTotal = cost.toString();

        print(
            '${newItem.itemName} with id ${existingItem.itemId} already exists and new cost is ${existingItem.subTotal}');
        print('Item quantity is ${existingItem.quantityInCart}');
        Get.snackbar(
          '1 more ${existingItem.itemName} add to cart',
          'If you want to delete ${existingItem.itemName} from cart just press and hold',
          backgroundColor: kWhiteLight,
        );
      } else {
        Get.snackbar(
          'An Error Occured',
          'Item not found in cart',
          backgroundColor: kWhiteLight,
        );
        print('Item not found in cart');
      }
    }
  }

  bool itemExistInCart(CheckOutItemModel newItem) {
    for (CheckOutItemModel item in cartItems) {
      if (item.itemId == newItem.itemId) {
        return true;
      }
    }
    return false;
  }

  List<CheckOutItemModel> convertCartItems(List cartFromDb) {
    List<CheckOutItemModel> result = [];
    for (var item in cartFromDb) {
      CheckOutItemModel.fromMap(item);
    }
    return result;
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
