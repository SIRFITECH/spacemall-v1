import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/data/receipts_repo.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_screen.dart';
import '../data/check_out_repo.dart';

class CartItemController extends GetxController {
  static CartItemController get instance => Get.put(
        CartItemController(),
      );
  final profileRepo = Get.put(ProfileRepo());
  final checkOutRepo = Get.put(CheckOutRepo());

  // final CartItemController cartItemController = Get.put(CartItemController(),);

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;

  RxDouble totalCartTotal = 0.0.obs;
  RxDouble totalCartSubTotal = 0.0.obs;
  RxDouble totalCartDiscount = 0.0.obs;
  RxDouble totalCartTax = 0.0.obs;
  RxInt tapedIndex = (-1).obs;
  RxInt items = 0.obs;
  RxBool isFirstTime = true.obs;
  int indexValue = 0;

  double discountRate = 0.1;
  double taxRate = 0.075;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

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
      subTotal += item.subTotal;
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
    AddItemModel stockItem = stockBox.getAt(index);
    Get.snackbar(
      '${cartItems[index].itemName}  Deleted ',
      '${cartItems[index].itemName} deleted successfully from cart',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    int quantity =
        cartItems[index].quantityInCart - cartItems[index].quantityInCart;

    cartItems[index].quantityInCart = quantity;

    stockItem.itemCount = cartItems[index].quantityInCart;
    items.value = 0;
    removeItemFromCart(index);
  }

  decreaseItemQuantityInCart(index) {
    int quantity = cartItems[index].quantityInCart - 1;
    cartItems[index].quantityInCart = quantity;

    // Recalculate the subtotal
    String priceString = cartItems[index].price.toString();
    String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    String quantityInCartString = cartItems[index].quantityInCart.toString();
    String numQuantityInCartString =
        quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
    double initCost =
        double.parse(numQuantityInCartString) * int.parse(numPriceString);
    double cost = initCost;
    cartItems[index].subTotal = cost;
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
    int quantity = cartItems[index].quantityInCart + 1;
    cartItems[index].quantityInCart = quantity;
    String priceString = cartItems[index].price.toString();
    String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    String quantityInCartString = cartItems[index].quantityInCart.toString();
    String numQuantityInCartString =
        quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
    double initCost =
        double.parse(numQuantityInCartString) * int.parse(numPriceString);
    double cost = initCost;
    CartItemController.instance.items.value++;

    cartItems[index].subTotal = cost;

    Get.snackbar(
      '1 more ${cartItems[index].itemName} add to cart',
      'If you want to delete ${cartItems[index].itemName} from cart just press and hold',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
  }

  updateItemState(index) {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: [],
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );

    // int quantity = cartItems[index].quantityInCart + 1;
    // cartItems[index].quantityInCart = quantity;
    // String priceString = cartItems[index].price.toString();
    // String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    // String quantityInCartString = cartItems[index].quantityInCart.toString();
    // String numQuantityInCartString =
    //     quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
    // double initCost =
    //     double.parse(numQuantityInCartString) * int.parse(numPriceString);
    // double cost = initCost;
    // CartItemController.instance.items.value++;

    // cartItems[index].subTotal = cost;
    String itemQuantityString = (int.parse(store.stock[index].itemQuantity) -
            cartItems[index].quantityInCart)
        .toString();

    store.stock[index].itemQuantity = itemQuantityString;
    items.value = 0;

    print(itemQuantityString);
  }

  Future<dynamic> showMoodOfPayment(
      BuildContext context, Size screenSize, bool isDarkMood, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                // border: Border.all(
                //   width: 1,
                //   color: isDarkMood
                //       ? kMainColorLight.withOpacity(0.9)
                //       : kMainComplimemtColorLight.withOpacity(0.8),
                // ),
                // shape: BoxShape.circle,
                // color: kLightModeActiveButtonColor,
                ),
            width: double.infinity,
            height: screenSize.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('SELECT PAYMENT MOOD'),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: 18.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            AddReceiptsRepo.instance.paymentMood = 'Cash';
                            ReceiptsController.instance.cartTotal.value =
                                CartItemController.instance.totalCartTotal.value
                                    .toString();
                            AddReceiptsRepo.instance
                                .saveReceiptData()
                                .then(
                                  (value) => Get.to(
                                    () => const ReceiptListScreen(),
                                  ),
                                )
                                .then((value) {
                              updateItemState(index);
                              AddReceiptsRepo.instance.paymentMood = '';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: !isDarkMood
                                    ? kMainColorLight.withOpacity(0.6)
                                    : kMainComplimemtColorLight
                                        .withOpacity(0.8),
                              ),
                            ),
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.35,
                            child: const Center(child: Text('cash')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AddReceiptsRepo.instance.paymentMood = 'Card';
                            ReceiptsController.instance.cartTotal.value =
                                CartItemController.instance.totalCartTotal.value
                                    .toString();
                            AddReceiptsRepo.instance
                                .saveReceiptData()
                                .then(
                                  (value) => Get.to(
                                    () => const ReceiptListScreen(),
                                  ),
                                )
                                .then((value) {
                              updateItemState(index);
                              AddReceiptsRepo.instance.paymentMood = '';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: !isDarkMood
                                    ? kMainColorLight.withOpacity(0.6)
                                    : kMainComplimemtColorLight
                                        .withOpacity(0.8),
                              ),
                            ),
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.35,
                            // color: kTextFieldDarkBorderColor,
                            child: const Center(child: Text('Card')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 64.0,
                      right: 16.0,
                      left: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            AddReceiptsRepo.instance.paymentMood =
                                'Bank Transfer';
                            ReceiptsController.instance.cartTotal.value =
                                CartItemController.instance.totalCartTotal.value
                                    .toString();
                            AddReceiptsRepo.instance
                                .saveReceiptData()
                                .then(
                                  (value) => Get.to(
                                    () => const ReceiptListScreen(),
                                  ),
                                )
                                .then((value) {
                              updateItemState(index);
                              AddReceiptsRepo.instance.paymentMood = '';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: !isDarkMood
                                    ? kMainColorLight.withOpacity(0.6)
                                    : kMainComplimemtColorLight
                                        .withOpacity(0.8),
                              ),
                            ),
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.35,
                            child: const Center(child: Text('Transfer')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AddReceiptsRepo.instance.paymentMood = 'POD';
                            ReceiptsController.instance.cartTotal.value =
                                CartItemController.instance.totalCartTotal.value
                                    .toString();
                            AddReceiptsRepo.instance
                                .saveReceiptData()
                                .then(
                                  (value) => Get.to(
                                    () => const ReceiptListScreen(),
                                  ),
                                )
                                .then((value) {
                              updateItemState(index);
                              AddReceiptsRepo.instance.paymentMood = '';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: !isDarkMood
                                    ? kMainColorLight.withOpacity(0.6)
                                    : kMainComplimemtColorLight
                                        .withOpacity(0.8),
                              ),
                            ),
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.35,
                            // color: kTextFieldDarkBorderColor,
                            child: const Center(child: Text('Pay On Delivery')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
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
  }

  /// FOURTH LOGIC

  void addToCart(
    CartItemModel newItem,
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
      var cart = checkOutRepo.getCheckOutCartFromBox();
      // cartItems.value = ;

      user!.cart.add(newItem);
      cart.add(newItem);
      cartItems.value = [...user.cart];

      Get.snackbar(
        'Operation Successful',
        'Item added to cart successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      // Item already exists in cart, update quantity and subtotal
      CartItemModel existingItem = cartItems.firstWhere(
        (item) => item.itemId == newItem.itemId,
      );

      if (existingItem.itemId.isNotEmpty) {
        int quantity = existingItem.quantityInCart + 1;
        existingItem.quantityInCart = quantity;
        String priceString = existingItem.price.toString();
        String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
        String quantityInCartString = existingItem.quantityInCart.toString();
        String numQuantityInCartString =
            quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
        double initCost =
            double.parse(numQuantityInCartString) * int.parse(numPriceString);
        double cost = initCost;

        existingItem.subTotal = cost;
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

  bool itemExistInCart(CartItemModel newItem) {
    for (CartItemModel item in cartItems) {
      if (item.itemId == newItem.itemId) {
        return true;
      }
    }
    return false;
  }

  List<CartItemModel> convertCartItems(List cartFromDb) {
    List<CartItemModel> result = [];
    for (var item in cartFromDb) {
      CartItemModel.fromMap(item);
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
