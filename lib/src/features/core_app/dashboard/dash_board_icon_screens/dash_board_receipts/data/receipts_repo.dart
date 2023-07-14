import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/reciepts_controller.dart';

class AddReceiptsRepo extends GetxController {
  static AddReceiptsRepo get instance => Get.find();
  final AddItemRepo addItemRepo = Get.put(AddItemRepo());
  final ReceiptsController receiptsController = Get.find();

  ///PHONE OPERATIONS

  Future saveReceiptData() async {
    // fetch store from storeBox
    StoreModel storeList = storeBox.get(
      addItemRepo.currentStore.value,
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
        storeName: storeList.storeName,
        businessEmail: storeList.contact,
        businessPhone: '',
        date: DateTime.now(),
        receiptNo: ReceiptsController.instance.receiptNo.value.toString(),
        attendant: '',
        receiptId: const Uuid().v4(),
        cartId: '');

    // Add the new stock item to the store's stock list
    storeList.receipts.add(newReceipt);

// update the storeBox
    await storeBox.put(
      addItemRepo.currentStore.value,
      storeList,
    );
    receiptsController.receipts.add(newReceipt);
    print(receiptsController.receipts.length);
    Get.back();
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
