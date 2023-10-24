import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/application/cart_item_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../constants/colors.dart';

import '../../../../profile/domain/user_model.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/reciepts_controller.dart';

class AddReceiptsRepo extends GetxController {
  static AddReceiptsRepo get instance => Get.find();
  final AddItemRepo addItemRepo = Get.put(AddItemRepo());
  final ReceiptsController receiptsController = Get.find();
  String paymentMood = '';

  ///PHONE OPERATIONS

  Future saveReceiptData() async {
    UserModel? user;
    // ignore: unnecessary_null_comparison
    if (CartItemController.instance.userModel == null) {
      user = CartItemController.instance.userModel;
    } else {
      user = await ProfileController.instance.getUserDataFromHive();
    }

    int receiptNo = ReceiptsController.instance.receiptNo.value++;
    String staffNumber = '0123456789';
    // List<CartItemModel> cartItemsList =
    //     CartItemController.instance.cartItems.toList();

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
    // print(user.cart.length);
    // create a new receipt
    ReceiptsModel newReceipt = ReceiptsModel(
      logo: null,
      customerName: 'New Customer',
      businessEmail: user!.email,
      cartTotal: receiptsController.cartTotal.value,
      date: DateTime.now(),
      receiptNo: receiptNo.toString().padLeft(8, '0'),
      attendant: user.userName,
      receiptId: const Uuid().v4(),
      cartId: '',
      itemsInCart: CartItemController.instance.cartItems.length.toString(),
      cart: [
        CartItemModel(
          itemId: 'itemId',
          itemName: 'itemName',
          quantityInCart: RxInt(1),
          price: '5000',
          totalItemPrice: '5000',
          subTotal: RxDouble(5000.0),
          discount: 50,
          tax: 35,
        ),
        CartItemModel(
          itemId: 'itemId',
          itemName: 'itemName',
          quantityInCart: RxInt(1),
          price: '5000',
          totalItemPrice: '5000',
          subTotal: RxDouble(5000.0),
          discount: 50,
          tax: 35,
        )
      ],

      // cartItemsList,
      paymentMethod: paymentMood,
      staffId: staffNumber.substring(4),
    );

    // Add the new receipt item to the store's receipts list
    store.receipts.add(newReceipt);

    // update the storeBox
    await storeBox.put(
      addItemRepo.currentStore.value,
      store,
    );

    Get.back();
    receiptsController.receipts.add(newReceipt);
    Get.snackbar(
      'Receipt created',
      'Receipt added successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );

    Get.back();
  }

  // stores from phone
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

  // get receipts
  List<ReceiptsModel> getStoresFromBox() {
    List<ReceiptsModel> receipts = [];
    for (var key in receiptsBox.keys) {
      if (key.startsWith('store-')) {
        ReceiptsModel? store = receiptsBox.get(key);
        if (store != null) {
          receipts.add(store);
        }
      }
    }
    return receipts;
  }
}
