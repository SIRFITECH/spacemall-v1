import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/repository/services/network_connectivity/receipt_firebase_services.dart';
import 'package:spacemall/src/repository/services/phone_storage/receipt_phone_services.dart';
import 'package:uuid/uuid.dart';

import '../../../../check_out/application/check_out_controller.dart';
import '../../../../profile/domain/user_model.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/receipts_controller.dart';

class ReceiptsRepo extends GetxController {
  // The purpose of this class is to write and read receipt to the db
  // its functions are:
  // 1. Write receipt to db
  // 2. write receipt to db

  static ReceiptsRepo get instance => Get.put(ReceiptsRepo());
  final AddItemRepo addItemRepo = Get.put(AddItemRepo());
  final ReceiptsController receiptsController = Get.put(ReceiptsController());
  String paymentMood = '';
  String receiptId = '';

  Future saveReceipt() async {
    // The onlt thing we want to do here is:
    // 1. to save the new receipt to firebase
    // 2. and also save it to phone if successfull

    int receiptNo = ReceiptsController.instance.receiptNo.value++;

    UserModel? user = await userBox.get('user_profile');
    String staffNumber = user!.contactNumber;

    // List<CartItemModel> userCart =
    //     CheckOutController.instance.cartItems.toList();

    // create a new receipt
    ReceiptsModel newReceipt = ReceiptsModel(
      logo: null,
      customerName: 'New Customer',
      businessEmail: user.email,
      cartTotal: receiptsController.cartTotal.value,
      date: DateTime.now(),
      receiptNo: receiptNo.toString().padLeft(8, '0'),
      attendant: user.userName,
      receiptId: const Uuid().v4(),
      cartId: receiptId,
      itemsInCart: CheckOutController.instance.cartItems.length.toString(),
      cart: [],
      paymentMethod: paymentMood,
      staffId: staffNumber.substring(4),
    );

    ReceiptFirebaseServices().saveNewReceiptToDB(
        newReceipt: newReceipt,
        onSucess: () {
          ReceiptPhoneService().saveReceiptToDevice(newReceipt);
        });
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
