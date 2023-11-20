import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../localizations/currency.dart';
import '../../../../repository/hive_boxes.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/data/receipts_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipt_pdf.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import '../data/check_out_repo.dart';
import '../screens/confirm_payment.dart';
import 'cart_item_controller.dart';

class CheckOutController extends GetxController {
  static CheckOutController get instance => Get.put(
        CheckOutController(),
      );

  final cartItemController = Get.put(CartItemController());
  final checkOutRepo = Get.put(CheckOutRepo());
  final profileConrtoller = Get.put(ProfileController());
  final receiptsController = Get.put(ReceiptsController());

  int indexValue = 0;

  RxInt cartTotalPrice = 0.obs;
  RxDouble totalCartTotal = 0.0.obs;
  RxDouble totalCartSubTotal = 0.0.obs;
  RxDouble totalCartDiscount = 0.0.obs;
  RxDouble totalCartTax = 0.0.obs;
  RxBool isFirstTime = true.obs;

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
            profilePicRemotePath: '');
  }

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  removeItemFromCart(
    int index,
  ) {
    cartItems.removeAt(index);
    updateItemQuantities();
    updateCartState();
    if (cartItems.isEmpty) {
      isFirstTime.value = true;
    }
  }

  deleteItemFromCart(index) {
    Get.snackbar(
      '${cartItems[index].itemName}  Deleted ',
      '${cartItems[index].itemName} deleted successfully from cart',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );

    // existingItem.quantityInCart.value = 0;

    removeItemFromCart(index);
    updateItemQuantities();
    updateCartState();
    setCartTransactionData();
  }

  void setSale(String saleAmount) {
    SalesController.instance.salesForTheDay.value = saleAmount;
  }

  void completeSale(String paymentMood) async {
    ReceiptsRepo.instance.paymentMood = paymentMood;
    ReceiptsController.instance.cartTotal.value =
        totalCartTotal.value.toString();

    cartItems.isNotEmpty
        ? (
            ReceiptsRepo.instance.saveReceipt().then((value) {
              setSale(totalCartTotal.value.toString());
              updateItemQuantities();
              updateCartState();
              previewReceipt();
            }).then(
              (value) {
                SalesController.instance.addNewSales();
                ReceiptsRepo.instance.paymentMood = '';
                clearCart();
              },
            ),

            // SalesController.instance.addNewSales()
          )
        : spaceMallSnackBar(
            'Error',
            'You can not checkout an empty cart',
            kWhiteLight,
            kRedColor,
          );
  }

  void clearCart() async {
    UserModel? user =
        _userModel ?? await profileConrtoller.getUserDataFromHive();

    // ignore: unnecessary_null_comparison
    if (user != null) {
      user.cart.clear();
      cartItems.value = [];
      totalCartSubTotal.value = 0.0;
      totalCartTotal.value = 0.0;
      totalCartDiscount.value = 0.0;
      totalCartTax.value = 0.0;
    } else {
      Get.snackbar(
        'Error',
        'Unable to clear cart',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

  Future previewReceipt() async {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
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

    final receipt = ReceiptPDFModel(
      seller: store,
      customer: CustomerModel(
        customerId: '',
        customerName: '',
        phone: '',
        totalOrder: '',
        lastOrder: DateTime.now(),
        debts: DebtsModel(
          debtId: '',
          customerName: '',
          payDate: DateTime.now(),
          phone: '',
          isPaid: true,
          cart: CartItemModel(
            itemId: '',
            itemName: '',
            quantityInCart: RxInt(0),
            price: '',
            totalItemPrice: '',
            subTotal: RxDouble(0),
            discount: 0.0,
            tax: 0.0,
          ),
          amountPayable: 0.0,
        ),
        receipts: ReceiptsModel(
          logo: null,
          customerName: '',
          businessEmail: '',
          cartTotal: '',
          date: DateTime.now(),
          receiptNo: '',
          attendant: '',
          receiptId: '',
          cartId: '',
          cart: [],
          itemsInCart: '',
          paymentMethod: '',
          staffId: '',
        ),
      ),
      recieptInfo: ReceiptsModel(
        logo: null,
        customerName: '',
        businessEmail: '',
        cartTotal: '',
        date: DateTime.now(),
        receiptNo: '',
        attendant: '',
        receiptId: '',
        cartId: '',
        cart: [],
        itemsInCart: '',
        paymentMethod: '',
        staffId: '',
      ),
      cartItem: CartItemModel(
        itemId: '',
        itemName: '',
        quantityInCart: RxInt(0),
        price: '',
        totalItemPrice: '',
        subTotal: RxDouble(0.0),
        discount: 0.0,
        tax: 0.0,
      ),
      totalCartPrice: '',
      cartId: '',
      subTotal: '',
      discount: '',
      tax: '',
    );

    CheckOutRepo.instance.generatePDFReceipt(receipt, indexValue);
  }

  void updateCartState() async {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );

    for (var cartItem in CheckOutController.instance.cartItems) {
      int index =
          store.stock.indexWhere((item) => item.itemId == cartItem.itemId);

      if (index >= 0) {
        store.stock[index].itemCount = 0;
        CartItemController.instance.items.value = 0;
      } else {
        Get.snackbar(
          'Error',
          'Item not found in store',
          backgroundColor: kRedColor,
          colorText: kWhiteLight,
        );
      }
    }
  }

  _setCartSubTotal() {
    double subTotal = 0;
    for (var item in cartItems) {
      subTotal += item.subTotal.value;
    }
    totalCartSubTotal.value = subTotal;
  }

  _setCartTotal() {
    double total =
        totalCartSubTotal.value - totalCartDiscount.value + totalCartTax.value;

    totalCartTotal.value = total;
    update();
  }

  _setCartDiscount(double discount) {
    double discountedAmount = totalCartSubTotal.value * (discount / 100);
    totalCartDiscount.value = discountedAmount;
  }

  _setCartTax(double tax) {
    double taxAmount = totalCartSubTotal.value * (tax / 100);
    totalCartTax.value = taxAmount;
  }

  void addToCart(
    CartItemModel newItem,
    BuildContext context,
  ) async {
    // Get the item quantity in the store
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );

    int itemQuantityInStore = int.parse(store.stock
        .firstWhere(
          (item) => item.itemId == newItem.itemId,
          orElse: () => AddItemModel(
              itemPic: null,
              itemName: '',
              itemSellingPrice: '',
              itemCategory: '',
              itemQuantity: '0',
              itemCostPrice: '',
              trackProfit: false,
              trackLowStock: false,
              preventItemSalesWhenOutOfStock: false,
              trackExpiry: '',
              expiryAlert: '',
              itemCount: 0,
              itemId: '',
              morePics: RxList([])),
        )
        .itemQuantity);

    int quantityToAdd = newItem.quantityInCart.value;

    // Check if item quantity is enough
    if (itemQuantityInStore > quantityToAdd) {
      if (!itemExistInCart(newItem)) {
        UserModel? user;
        if (_userModel == null) {
          user = await profileConrtoller.getUserDataFromHive();
        } else {
          user = _userModel;
        }

        // var cart = cart;

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

        // print('${existingItem.itemName} already in cart');

        if (existingItem.itemId.isNotEmpty) {
          int quantity = quantityToAdd;

          existingItem.quantityInCart.value = quantity;

          String priceString = existingItem.price.toString();
          String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
          String quantityInCartString = existingItem.quantityInCart.toString();
          String numQuantityInCartString =
              quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
          double initCost =
              double.parse(numQuantityInCartString) * int.parse(numPriceString);
          double cost = initCost;

          existingItem.subTotal.value = cost;
          setCartTransactionData();
        } else {
          Get.snackbar(
            'An Error Occured',
            'Item not found in cart',
            backgroundColor: kRedColor,
            colorText: kWhiteLight,
          );
        }
      }
    } else {
      // Item quantity is not enough, print error message
      Get.snackbar(
        'Limit Warning',
        'You have reach the item limit, you can only add $itemQuantityInStore units to cart',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
    }
  }

  setCartTransactionData() {
    _setCartSubTotal();
    _setCartDiscount(10);
    _setCartTax(7.5);
    _setCartTotal();
  }

  void decreaseItemQuantityInCart(index) async {
    /// it want to reverse what was don in addItem
    /// - remove the item from cart
    /// - set the itemCount to 0 globally
    /// - clear the cartList
    /// - reset total prices
    ///

    CartItemModel existingItem = cartItems[index];
    int quantity = existingItem.quantityInCart.value;

    if (quantity > 1) {
      existingItem.quantityInCart--;
      String priceString = existingItem.price.toString();
      String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
      String quantityInCartString = existingItem.quantityInCart.toString();
      String numQuantityInCartString =
          quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
      double initCost =
          double.parse(numQuantityInCartString) * int.parse(numPriceString);
      double cost = initCost;
      existingItem.subTotal.value = cost;
      setCartTransactionData();
    } else {
      /// -get the item we are dealing with
      /// -get the item in the phone memory
      /// -modify the itemCount of the item
      /// -remove the item from cart
      ///
      var cart = checkOutRepo.getCheckOutCartFromBox();
      StoreModel store = storeBox.get(
        AddItemRepo.instance.currentStore.value,
        defaultValue: StoreModel(
          logoLocalPath: '',
          logoRemotePath: '',
          storeName: '',
          bankName: '',
          accountNumber: '',
          contact: '',
          stock: RxList([]),
          receipts: [],
          debts: [],
          staff: [],
          sales: [],
          customer: [],
          storeId: '',
          categories: [],
        ),
      );
      existingItem.quantityInCart = RxInt(0);
      String id = store.stock
          .firstWhere(
            (item) => item.itemId == existingItem.itemId,
            orElse: () => AddItemModel(
                itemPic: null,
                itemName: '',
                itemSellingPrice: '',
                itemCategory: '',
                itemQuantity: '0',
                itemCostPrice: '',
                trackProfit: false,
                trackLowStock: false,
                preventItemSalesWhenOutOfStock: false,
                trackExpiry: '',
                expiryAlert: '',
                itemCount: 0,
                itemId: '',
                morePics: RxList([])),
          )
          .itemId;

      cartItems.removeWhere(
        (item) => item.itemId == id,
      );

      UserModel? user;
      if (_userModel == null) {
        user = await profileConrtoller.getUserDataFromHive();
      } else {
        user = _userModel;
      }

      user!.cart.remove(existingItem);
      cart.remove(existingItem);
      cartItems.value = [...user.cart];

      setCartTransactionData();
    }
  }

  void increaseItemQuantityInCart(index) {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
    );
    int itemQuantityInStore = int.parse(store.stock
        .firstWhere(
          (item) => item.itemId == cartItems[index].itemId,
          orElse: () => AddItemModel(
              itemPic: null,
              itemName: '',
              itemSellingPrice: '',
              itemCategory: '',
              itemQuantity: '0',
              itemCostPrice: '',
              trackProfit: false,
              trackLowStock: false,
              preventItemSalesWhenOutOfStock: false,
              trackExpiry: '',
              expiryAlert: '',
              itemCount: 0,
              itemId: '',
              morePics: RxList([])),
        )
        .itemQuantity);

    int quantityToAdd = cartItems[index].quantityInCart.value;

    if (itemQuantityInStore > 0) {
      if (itemQuantityInStore > quantityToAdd) {
        CartItemModel existingItem = cartItems.firstWhere(
          (item) => item.itemId == cartItems[index].itemId,
        );
        if (existingItem.itemId.isNotEmpty) {
          existingItem.quantityInCart++;
          String priceString = existingItem.price.toString();
          String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
          String quantityInCartString = existingItem.quantityInCart.toString();
          String numQuantityInCartString =
              quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
          double initCost =
              double.parse(numQuantityInCartString) * int.parse(numPriceString);
          double cost = initCost;
          existingItem.subTotal.value = cost;

          setCartTransactionData();
        } else {
          spaceMallSnackBar(
            'An Error Occured',
            'Item not found in cart',
            kWhiteLight,
            kRedColor,
          );
        }
      } else {
        Get.snackbar(
          'Limit Warning',
          'You have reach the item limit,\n You can only add $itemQuantityInStore units of ${cartItems[index].itemName} to cart',
          backgroundColor: kRedColor,
          colorText: kWhiteLight,
        );
      }
    } else {
      Get.snackbar(
        'Error adding ${cartItems[index].itemName} to cart',
        'You can not add more than ${cartItems[index].quantityInCart} ${cartItems[index].itemName} to cart',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    }
  }

  void updateItemQuantities() async {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );

    for (var cartItem in cartItems) {
      int index =
          store.stock.indexWhere((item) => item.itemId == cartItem.itemId);

      if (index >= 0) {
        int itemQuantityBought = cartItem.quantityInCart.value;
        String itemQuantityinStore = store.stock[index].itemQuantity;
        int newItemQuantityinStore =
            int.parse(itemQuantityinStore) - itemQuantityBought;

        // Update the item quantity in the store
        store.stock[index].itemQuantity = newItemQuantityinStore.toString();

        // Update the storeBox
        await storeBox.put(
          AddItemRepo.instance.currentStore.value,
          store,
        );
      } else {
        spaceMallSnackBar(
          'Error',
          'Item not found in store',
          kWhiteLight,
          kRedColor,
        );
      }
    }
  }

// Used to initiate the checkout sequence from the checkOut  screen,
// first step is in the confirm payment screen

  Future<void> moveToConfirmPayment() async {
    setCartTransactionData();
    Get.to(() => const ConfirmPayment());
  }

  bool itemExistInCart(CartItemModel newItem) {
    for (CartItemModel item in cartItems) {
      if (item.itemId == newItem.itemId) {
        return true;
      }
    }
    return false;
  }

  var cart = CheckOutRepo.instance.getCheckOutCartFromBox();

  List<CartItemModel> convertCartItems(List cartFromDb) {
    List<CartItemModel> result = [];
    for (var item in cartFromDb) {
      CartItemModel.fromMap(item);
    }
    return result;
  }

  Future<dynamic> showModeOfPayment(
      BuildContext context, Size screenSize, bool isDarkMood, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          var cartIsEmpty = CheckOutController.instance.cartItems;
          return Container(
            decoration: const BoxDecoration(),
            width: double.infinity,
            height: screenSize.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  const Text('SELECT PAYMENT MODE'),
                  cartIsEmpty.isNotEmpty
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'The cart total is ',
                                style: TextStyle(
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                ),
                              ),
                              TextSpan(
                                text: nairaFormat.format(CheckOutController
                                    .instance.totalCartTotal.value),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text('The cart is empty'),
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
                          onTap: () async {
                            completeSale('Cash');
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    kPaymentCash,
                                    width: 50,
                                    height: 40,
                                  ),
                                ),
                                const Center(child: Text('cash')),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            completeSale('Card');
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    // kPaymentCard,
                                    kProfileIcon,
                                    // ignore: deprecated_member_use
                                    color: isDarkMood
                                        ? kMainComplimemtColorLight
                                        : kMainColorLight,
                                    width: 50,
                                    height: 40,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const Center(child: Text('Card')),
                              ],
                            ),
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
                            completeSale('Bank Transfer');
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    // kProfileIcon,
                                    kMenuIcon,
                                    // kPaymentBank,
                                    // ignore: deprecated_member_use
                                    color: isDarkMood
                                        ? kMainComplimemtColorLight
                                        : kMainColorLight,
                                    width: 50,
                                    height: 40,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const Center(child: Text('Transfer')),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            completeSale('POD');
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    kProfileIcon,
                                    // kPaymentPOD,
                                    // ignore: deprecated_member_use
                                    color: isDarkMood
                                        ? kMainComplimemtColorLight
                                        : kMainColorLight,
                                    width: 50,
                                    height: 40,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const Center(
                                  child: Text('Pay On Delivery'),
                                ),
                              ],
                            ),
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
}
