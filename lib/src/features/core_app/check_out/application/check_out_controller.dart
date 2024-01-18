import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipt_pdf.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_screen.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/services/phone_storage/sales_phone_services.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../localizations/currency.dart';
import '../../../../repository/hive_boxes.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/data/receipts_repo.dart';
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
  TextEditingController stockSearchController = TextEditingController();

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

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  RxList<AddItemModel> filteredStocks = <AddItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    List<AddItemModel> stockInStore =
        AddItemController.instance.allStockInStore(store);
    filteredStocks.value = List.from(stockInStore);
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
    spaceMallSnackBar(
      '${cartItems[index].itemName}  Deleted ',
      '${cartItems[index].itemName} deleted successfully from cart',
      kWhiteLight,
      kBlack,
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

  void completeSale(
      String paymentMode, bool isDarkMood, Size screenSize) async {
    ReceiptsRepo.instance.paymentMood = paymentMode;
    ReceiptsController.instance.cartTotal.value =
        totalCartTotal.value.toString();

    String cartTotal = nairaFormat
        .format(double.parse(ReceiptsController.instance.cartTotal.value));

    String paymentMethod = ReceiptsRepo.instance.paymentMood;

    cartItems.isNotEmpty
        ?
        // dialogBox(isDarkMood, 'Confirm Payment','You are recieving $cartTotal by $paymentMethod',)

        Get.defaultDialog(
            backgroundColor: !isDarkMood
                ? kDarkModeBackgroundColor.withOpacity(0.1)
                : kWhiteDark.withOpacity(0.1),
            title: 'Confirm Payment',
            titleStyle: const TextStyle(
              color: kWhiteLight,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
            content: Text(
              'You are recieving $cartTotal by $paymentMethod',
              style: const TextStyle(
                color: kWhiteLight,
                fontSize: kBodyTextFont,
              ),
            ),
            confirm: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .135),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreyColor,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: kBodyTextFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      (
                        SalesController.instance
                            .addNewSales(ReceiptsRepo.instance.paymentMood)
                            .then(
                          (value) {
                            ReceiptsRepo.instance.saveReceipt().then((value) {
                              setSale(totalCartTotal.value.toString());
                              updateItemQuantities();
                              updateCartState();
                            });
                          },
                        ).then((value) {
                          //TODO: flesh up the ReceiptView() with right data
                          Get.defaultDialog(
                            backgroundColor: !isDarkMood
                                ? kDarkModeBackgroundColor
                                // .withOpacity(0.1)
                                : kWhiteDark
                            // .withOpacity(0.1)
                            ,
                            title: 'Success!!!',
                            titleStyle: const TextStyle(
                              color: kWhiteLight,
                              fontSize: kBodyTextFont,
                              fontWeight: FontWeight.w900,
                            ),
                            content: const Text(
                              // 'You are recieving $cartTotal by $paymentMethod',
                              'Do you want to print the receipt?',
                              style: TextStyle(
                                color: kWhiteLight,
                                fontSize: kBodyTextFont,
                              ),
                            ),
                            confirm: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.off(() => Stock());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kGreyColor,
                                    ),
                                    child: const Text(
                                      'Go Back',
                                      style: TextStyle(
                                        fontSize: kBodyTextFont,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.off(() => const ReceiptListScreen());
                                    },
                                    child: const Text(
                                      'Print Receipt',
                                      style: TextStyle(
                                        color: kWhiteLight,
                                        fontSize: kBodyTextFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          // Get.to(
                          //   () => ReceiptView(
                          //     receipt: ReceiptsModel(
                          //       logo: null,
                          //       customerName: receipstList.last.customerName,
                          //       businessEmail: receipstList.last.businessEmail,
                          //       cartTotal:
                          //           ReceiptsController.instance.cartTotal.value,
                          //       date: receipstList.last.date,
                          //       receiptNo: receipstList.last.receiptNo,
                          //       attendant: receipstList.last.attendant,
                          //       receiptId: receipstList.last.receiptId,
                          //       cartId: receipstList.last.cartId,
                          //       itemsInCart: receipstList.last.itemsInCart,
                          //       paymentMethod: receipstList.last.paymentMethod,
                          //       staffId: receipstList.last.staffId,
                          //       cart: cart,
                          //     ),
                          //     fromCart: false,
                          //   ),
                          // );

                          ReceiptsRepo.instance.paymentMood = '';
                          clearCart();
                        }),
                      );
                    },
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: kBodyTextFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : spaceMallSnackBar(
            'Empty Cart Error',
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
      spaceMallSnackBar(
        'Error',
        'Unable to clear cart',
        kWhiteLight,
        kRedColor,
      );
    }
  }

  Future previewReceipt(String saleId, Size screenSize) async {
    List<dynamic> cart = await SalesPhoneService().getSalesFromDevice(saleId);
    List<CartItemModel> receiptList = [];
    double total = 0.0;
    double subTotal = 0.0;
    double discount = 0.0;
    double tax = 0.0;
    for (var i = 0; i < cart.length; i++) {
      String itemPrice = cart[i]['itemPrice'];
      CartItemModel cartItem = CartItemModel(
        itemId: cart[i]['itemId'],
        itemName: cart[i]['itemName'],
        quantityInCart: RxInt(cart[i]['quantityInCart']),
        price: cart[i]['itemPrice'],
        totalItemPrice: cart[i]['totalItemPrice'],
        subTotal: RxDouble(cart[i]['subTotal']),
        discount: cart[i]['discount'],
        tax: cart[i]['tax'],
      );
      subTotal += int.parse(itemPrice.replaceAll(RegExp(r'[^\d]'), ''));
      receiptList.add(cartItem);
    }

    discount = subTotal * 0.1;

    tax = subTotal * 0.075;
    total = (subTotal + tax) - discount;

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
          date:
              // cart[i]['tax'],
              DateTime.now(),
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
      cartItem: receiptList,
      totalCartPrice: total.toString(),
      cartId: '',
      subTotal: subTotal.toString(),
      discount: discount.toString(),
      tax: tax.toString(),
    );
    // print('lets see the cart: $cart');
    CheckOutRepo.instance.generatePDFReceipt(receipt, indexValue, screenSize);
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
        spaceMallSnackBar(
          'Error',
          'Item not found in store',
          kWhiteLight,
          kRedColor,
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

  _setCartDiscount(double discountPacentage) {
    double discountedAmount =
        totalCartSubTotal.value * (discountPacentage / 100);
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

        spaceMallSnackBar(
          'Operation Successful',
          'Item added to cart successfully',
          kBlack,
          kWhiteLight,
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
          spaceMallSnackBar(
            'An Error Occured',
            'Item not found in cart',
            kWhiteLight,
            kRedColor,
          );
        }
      }
    } else {
      // Item quantity is not enough, print error message
      spaceMallSnackBar(
        'Limit Warning',
        'You have reach the item limit, you can only add $itemQuantityInStore units to cart',
        kWhiteLight,
        kRedColor,
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
  var clearCheckOutCart = CheckOutRepo.instance.clearCheckOutCart();

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
                  const Text(
                    'SELECT PAYMENT MODE',
                    style: TextStyle(
                      fontSize: kBodyTextFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  cartIsEmpty.isNotEmpty
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'The cart total is ',
                                style: TextStyle(
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                  fontSize: kBodyTextFont,
                                ),
                              ),
                              TextSpan(
                                text: nairaFormat.format(CheckOutController
                                    .instance.totalCartTotal.value),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                  fontSize: kBodyTextFont,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text(
                          'The cart is empty',
                          style: TextStyle(
                            fontSize: kBodyTextFont,
                          ),
                        ),
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
                            completeSale('Cash', isDarkMood, screenSize);
                          },
                          child: PaymentModeCard(
                            isDarkMood: isDarkMood,
                            screenSize: screenSize,
                            paymentMethod: 'Cash',
                            paymentIcon: kPaymentCash,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            completeSale('Card', isDarkMood, screenSize);
                          },
                          child: PaymentModeCard(
                            isDarkMood: isDarkMood,
                            screenSize: screenSize,
                            paymentMethod: 'Card',
                            paymentIcon: kPaymentCard,
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
                            completeSale(
                                'Bank Transfer', isDarkMood, screenSize);
                          },
                          child: PaymentModeCard(
                            isDarkMood: isDarkMood,
                            screenSize: screenSize,
                            paymentMethod: 'Transfer',
                            paymentIcon: kPaymentBank,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            completeSale('POD', isDarkMood, screenSize);
                          },
                          child: PaymentModeCard(
                            isDarkMood: isDarkMood,
                            screenSize: screenSize,
                            paymentMethod: 'Pay On Delivery',
                            paymentIcon: kPaymentPOD,
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

  void filterStocks(String searchText) {
    List<AddItemModel> stockInStore =
        AddItemController.instance.allStockInStore(store);
    filteredStocks.clear();
    if (searchText.isEmpty) {
      debugPrint('$searchText is empty');
      // if no item is searched, return all items in store
      filteredStocks.addAll(stockInStore);
    } else {
      // Filter stocks based on the search text
      filteredStocks.addAll(
        stockInStore.where(
          (stockInStore) => stockInStore.itemName
              .toLowerCase()
              .contains(searchText.toLowerCase()),
        ),
      );
    }
  }
}

class PaymentModeCard extends StatelessWidget {
  final bool isDarkMood;
  final Size screenSize;
  final String paymentMethod;
  final String paymentIcon;

  const PaymentModeCard({
    super.key,
    required this.isDarkMood,
    required this.screenSize,
    required this.paymentMethod,
    required this.paymentIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: !isDarkMood
              ? kMainColorLight.withOpacity(0.6)
              : kMainComplimemtColorLight.withOpacity(0.8),
        ),
      ),
      height: screenSize.height * 0.1,
      width: screenSize.width * 0.35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              paymentIcon,
              width: 50,
              height: 40,
            ),
          ),
          Center(
              child: Text(
            paymentMethod,
            style: const TextStyle(
              fontSize: kBodyTextFont,
            ),
          )),
        ],
      ),
    );
  }
}
