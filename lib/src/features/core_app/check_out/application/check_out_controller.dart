import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';

class CheckOutItemController extends GetxController {
  static CheckOutItemController get instance => Get.put(
        CheckOutItemController(),
      );
  final profileRepo = Get.put(ProfileRepo());

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;

  RxDouble totalCartTotal = 0.0.obs;
  RxDouble totalCartSubTotal = 0.0.obs;
  RxDouble totalCartDiscount = 0.0.obs;
  RxDouble totalCartTax = 0.0.obs;
  RxInt tapedIndex = (-1).obs;
  RxInt items = RxInt(0);
  RxBool isFirstTime = true.obs;

  double discountRate = 0.1;
  double taxRate = 0.075;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  RxList<CheckOutItemModel> cartItems = <CheckOutItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    setCartSubTotal();
    setCartTotal();
    setCartDiscount(totalCartDiscount.value);
    setCartTax(totalCartTax.value);
  }

  setCartSubTotal() {
    double subTotal = 0;
    for (var item in cartItems) {
      subTotal += int.parse(item.subTotal);
    }
    totalCartSubTotal.value = subTotal;
  }

  setCartTotal() {
    double total =
        totalCartSubTotal.value - totalCartDiscount.value + totalCartTax.value;
    totalCartTotal.value = total;
  }

  setCartDiscount(double discount) {
    double discountedAmount = totalCartSubTotal.value * discount;
    totalCartDiscount.value = discountedAmount;
  }

  setCartTax(double tax) {
    double taxAmount = totalCartSubTotal.value * tax;
    totalCartTax.value = taxAmount;
  }

  removeItemFromCart(
    int index,
  ) {
    cartItems.removeAt(index);

    if (cartItems.isEmpty) {
      isFirstTime.value = true;
    }
  }

  deleteItemFromCart(index) {
    AddItemModel stockItem = stockItemBox.getAt(index);
    Get.snackbar(
      '${cartItems[index].itemName}  Deleted ',
      '${cartItems[index].itemName} deleted successfully from cart',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    num quantity = int.parse(cartItems[index].quantityInCart) -
        int.parse(cartItems[index].quantityInCart);

    cartItems[index].quantityInCart = quantity.toString();

    stockItem.itemCount = int.parse(cartItems[index].quantityInCart);
    items.value = 0;
    removeItemFromCart(index);
  }

  decreaseItemQuantityInCart(index) {
    num quantity = int.parse(cartItems[index].quantityInCart) - 1;
    cartItems[index].quantityInCart = quantity.toString();

    // Recalculate the subtotal
    String priceString = cartItems[index].price;
    String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    String quantityInCartString = cartItems[index].quantityInCart;
    String numQuantityInCartString =
        quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
    num initCost =
        int.parse(numQuantityInCartString) * int.parse(numPriceString);
    num cost = initCost;
    cartItems[index].subTotal = cost.toString();
    items.value--;

    if (int.parse(numQuantityInCartString) < 1) {
      removeItemFromCart(index);
      Get.snackbar(
        '${cartItems[index].itemName}  Deleted ',
        '${cartItems[index].itemName} deleted successfully from cart',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      Get.snackbar(
        '1 ${cartItems[index].itemName}  Deleted ',
        '1 ${cartItems[index].itemName} has been removed from cart',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    }
  }

  increaseItemQuantityInCart(index) {
    num quantity = int.parse(cartItems[index].quantityInCart) + 1;
    cartItems[index].quantityInCart = quantity.toString();
    String priceString = cartItems[index].price;
    String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    String quantityInCartString = cartItems[index].quantityInCart;
    String numQuantityInCartString =
        quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
    num initCost =
        int.parse(numQuantityInCartString) * int.parse(numPriceString);
    num cost = initCost;
    CheckOutItemController.instance.items.value++;

    cartItems[index].subTotal = cost.toString();

    // cartItems.forEach((item) {
    //   int itemCost = int.parse(item.subTotal);
    //   totalCartSubTotal.value = itemCost++;
    // });
    // for (CheckOutItemModel item in cartItems) {
    //   int itemCost = int.parse(item.subTotal);
    //   totalCartSubTotal.value = itemCost++;
    // }
    // CheckOutItemController.instance.totalCartSubTotal.value =
    //     int.parse(cartItems[index].subTotal);
    Get.snackbar(
      '1 more ${cartItems[index].itemName} add to cart',
      'If you want to delete ${cartItems[index].itemName} from cart just press and hold',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
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

  /// FOURTH LOGIC

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
        Get.snackbar(
          '1 more ${existingItem.itemName} add to cart',
          'If you want to delete ${existingItem.itemName} from cart just press and hold',
          backgroundColor: kWhiteLight,
          colorText: kBlack,
        );
      } else {
        Get.snackbar(
          'An Error Occured',
          'Item not found in cart',
          backgroundColor: kWhiteLight,
          colorText: kBlack,
        );
        // print('Item not found in cart');
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
