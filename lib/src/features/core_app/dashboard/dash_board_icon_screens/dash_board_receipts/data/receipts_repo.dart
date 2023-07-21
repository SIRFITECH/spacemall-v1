import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../constants/colors.dart';

import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/reciepts_controller.dart';

class AddReceiptsRepo extends GetxController {
  static AddReceiptsRepo get instance => Get.find();
  final AddItemRepo addItemRepo = Get.put(AddItemRepo());
  final ReceiptsController receiptsController = Get.find();

  ///PHONE OPERATIONS

  Future saveReceiptData() async {
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

    // create a new receipt
    ReceiptsModel newReceipt = ReceiptsModel(
      logo: null,
      customerName: 'New Customer',
      businessEmail: 'storeList.contact',
      cartTotal: receiptsController.cartTotal.value,
      date: DateTime.now(),
      receiptNo: ReceiptsController.instance.receiptNo.value.toString(),
      attendant: '',
      receiptId: const Uuid().v4(),
      cartId: '',
      itemsInCart: CartItemController.instance.cartItems.length.toString(),
      paymentMethod: '',
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

  // // clear the TextEditingControllers
  // clearControllers() {
  //   addItemController.itemName.clear();
  //   addItemController.sellingPrice.clear();
  //   addItemController.stockAvailable.clear();
  //   addItemController.costPrice.clear();
  //   addItemController.trackExpiry.clear();
  //   addItemController.expiryAlert.clear();
  //   addItemController.itemPic.value = null;
  //   addCategoryController.categoryValue.value = null;
  //   addItemController.trackProfit.value = false;
  //   addItemController.trackLowStock.value = false;
  //   addItemController.preventItemSalesWhenOutOfStock.value = false;
  //   dateFieldController.expiryTapped.value = false;
  //   dateFieldController.alertTapped.value = false;
  //   dateFieldController.isTapped.value = false;
  // }
}
