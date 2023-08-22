import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/data/receipts_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';

import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipt_pdf.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import '../data/check_out_repo.dart';
import '../domain/cart_model.dart';

class CartItemController extends GetxController {
  static CartItemController get instance => Get.put(
        CartItemController(),
      );
  final profileRepo = Get.put(ProfileRepo());
  final checkOutRepo = Get.put(CheckOutRepo());

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;
  // RxBool isInCart = false.obs;

  RxDouble totalCartTotal = 0.0.obs;
  RxDouble totalCartSubTotal = 0.0.obs;
  RxDouble totalCartDiscount = 0.0.obs;
  RxDouble totalCartTax = 0.0.obs;

  RxInt tapedIndex = (-1).obs;
  RxInt items = 0.obs;
  RxInt cartQuantity = 0.obs;
  RxBool isFirstTime = true.obs;
  int indexValue = 0;

  double discountRate = 0.1;
  double taxRate = 0.075;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  setCartSubTotal() {
    double subTotal = 0;
    for (var item in cartItems) {
      subTotal += item.subTotal.value;
    }
    totalCartSubTotal.value = subTotal;
  }

  setCartTotal() {
    double total =
        totalCartSubTotal.value - totalCartDiscount.value + totalCartTax.value;

    totalCartTotal.value = total;
    update();
  }

  setCartDiscount(double discount) {
    double discountedAmount = totalCartSubTotal.value * (discount / 100);
    totalCartDiscount.value = discountedAmount;
  }

  setCartTax(double tax) {
    double taxAmount = totalCartSubTotal.value * (tax / 100);
    totalCartTax.value = taxAmount;
  }

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
    setCartSubTotal();
    setCartDiscount(10);
    setCartTax(7.5);
    setCartTotal();
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
      existingItem.quantityInCart.value--;
      String priceString = existingItem.price.toString();
      String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
      String quantityInCartString = existingItem.quantityInCart.toString();
      String numQuantityInCartString =
          quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
      double initCost =
          double.parse(numQuantityInCartString) * int.parse(numPriceString);
      double cost = initCost;
      existingItem.subTotal.value = cost;

      setCartSubTotal();
      setCartDiscount(10);
      setCartTax(7.5);
      setCartTotal();
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
          logo: null,
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
      existingItem.quantityInCart.value = 0;
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
                itemCount: RxInt(0),
                itemId: '',
                morePics: RxList([])),
          )
          .itemId;

      cartItems.removeWhere(
        (item) => item.itemId == id,
      );

      UserModel? user;
      if (_userModel == null) {
        user = await profileRepo.getUserDataFromPhone();
      } else {
        user = _userModel;
      }

      user!.cart.remove(existingItem);
      cart.remove(existingItem);
      cartItems.value = [...user.cart];

      setCartSubTotal();
      setCartDiscount(10);
      setCartTax(7.5);
      setCartTotal();
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
              itemCount: RxInt(0),
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
          existingItem.quantityInCart.value++;
          String priceString = existingItem.price.toString();
          String numPriceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
          String quantityInCartString = existingItem.quantityInCart.toString();
          String numQuantityInCartString =
              quantityInCartString.replaceAll(RegExp(r'[^0-9]'), '');
          double initCost =
              double.parse(numQuantityInCartString) * int.parse(numPriceString);
          double cost = initCost;
          existingItem.subTotal.value = cost;
          setCartSubTotal();
          setCartDiscount(10);
          setCartTax(7.5);
          setCartTotal();
        } else {
          Get.snackbar(
            'An Error Occured',
            'Item not found in cart',
            backgroundColor: kRedColor,
            colorText: kWhiteLight,
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
        logo: null,
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

    for (var cartItem in CartItemController.instance.cartItems) {
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
        Get.snackbar(
          'Error',
          'Item not found in store',
          backgroundColor: kRedColor,
          colorText: kWhiteLight,
        );
      }
    }
  }

  void setSale(String saleAmount) {
    SalesController.instance.salesForTheDay.value = saleAmount;
  }

  void completeSale(String paymentMood) async {
    AddReceiptsRepo.instance.paymentMood = paymentMood;
    ReceiptsController.instance.cartTotal.value =
        CartItemController.instance.totalCartTotal.value.toString();

    CartItemController.instance.cartItems.isNotEmpty
        ? (AddReceiptsRepo.instance.saveReceiptData().then((value) {
            setSale(
                CartItemController.instance.totalCartTotal.value.toString());
            updateItemQuantities();
            updateCartState();

            previewReceipt();
          }).then(
            (value) {
              SalesController.instance.addNewSales();
              AddReceiptsRepo.instance.paymentMood = '';
              clearCart();
            },
          ))
        : Get.snackbar(
            'Error',
            'You can not checkout an empty cart',
            backgroundColor: kRedColor,
            colorText: kWhiteLight,
          );
  }

  void updateCartState() async {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
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

    for (var cartItem in CartItemController.instance.cartItems) {
      int index =
          store.stock.indexWhere((item) => item.itemId == cartItem.itemId);

      if (index >= 0) {
        store.stock[index].itemCount = RxInt(0);
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

  void clearCart() async {
    UserModel? user = _userModel ?? await profileRepo.getUserDataFromPhone();

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
          itemsInCart: '',
          paymentMethod: '',
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
        itemsInCart: '',
        paymentMethod: '',
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

  Future<dynamic> showMoodOfPayment(
      BuildContext context, Size screenSize, bool isDarkMood, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          var cartIsEmpty = CartItemController.instance.cartItems;
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
                                text: nairaFormat.format(CartItemController
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
                            child: const Center(child: Text('cash')),
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
                            child: const Center(child: Text('Transfer')),
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
                            child: const Center(
                              child: Text('Pay On Delivery'),
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
          stores: RxList<StoreModel>([]),
          createdAt: '',
        );
  }

  /// FOURTH LOGIC

  void addToCart(
    CartItemModel newItem,
    BuildContext context,
  ) async {
    // Get the item quantity in the store
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
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
              itemCount: RxInt(0),
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
          user = await profileRepo.getUserDataFromPhone();
        } else {
          user = _userModel;
        }

        var cart = checkOutRepo.getCheckOutCartFromBox();

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
          setCartSubTotal();
          setCartDiscount(10);
          setCartTax(7.5);
          setCartTotal();
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

  CartModel? getCartById(List<CartModel> carts, String cartId) {
    return carts.firstWhere(
      (cart) => cart.cartId == cartId,
      orElse: () => CartModel(
        cartId: cartId,
        itemName: '',
        quantityInCart: '',
        totalItemPrice: '',
        totalCartPrice: '',
        numOfItemsInCart: '',
        subTotal: '',
        discount: '',
        tax: '',
      ),
    );
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

  // RxList<CategoryModel> categoriesInStore = <CategoryModel>[].obs;

  ScrollController categoryScrollController = ScrollController();
  ScrollController gridScrollController = ScrollController();
}
