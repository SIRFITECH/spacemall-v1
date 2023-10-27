import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/application/dash_baord_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';

import 'package:uuid/uuid.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../domain/sales_model.dart';

class SalesController extends GetxController {
  static SalesController get instance => Get.find();

  DateTime now = DateTime.now();
  RxString date = ''.obs;
  String payment = '';

  RxString salesForTheDay = '0'.obs;

  TextEditingController paymentMethod = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController dueTime = TextEditingController();

  DateTime yesterday = DateTime.now().subtract(const Duration(days: 7));

  Future<DateTime> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    return pickedDate ?? DateTime.now();
  }

  Future<dynamic> pickiOSDate(BuildContext context, Size screenSize) async {
    DateTime? pickedDate;
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
          child: Container(
            decoration: const BoxDecoration(
                color: kWhiteLight,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: screenSize.height * 0.3,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.2,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    showDayOfWeek: true,
                    onDateTimeChanged: (DateTime newDate) {
                      pickedDate = newDate;
                    },
                  ),
                ),
                CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Get.back();
                    })
              ],
            ),
          ),
        ),
      ),
    );
    return pickedDate ?? DateTime.now();
  }

  Future<String> pickYesterday(BuildContext context) async {
    now = now.subtract(const Duration(days: 1));
    DateTime pickedDate = now;

    return date.value = DateFormat('d MMM').format(
      pickedDate.subtract(const Duration(days: 1)),
    );
  }

  Future<String> pickTommorow(BuildContext context) async {
    now = now.add(const Duration(days: 1));

    DateTime pickedDate = now;

    return date.value = DateFormat('d MMM').format(
      pickedDate.add(const Duration(days: 1)),
    );
  }

  List<SalesModel> convertSales(List salesFromDb) {
    List<SalesModel> result = [];
    for (var item in salesFromDb) {
      SalesModel.fromMap(item);
    }
    return result;
  }

  addNewSales() async {
    salesBox = await Hive.openBox<SalesModel>('sales');
    String paymentMood = payment;

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

    // Create a new sale
    SalesModel newSale = SalesModel(
      customerName: 'New Customer',
      saleId: const Uuid().v4(),
      attendant: '',
      date: DateTime.now(),
      cart: CartItemModel(
        itemId: 'stockItem.itemId',
        itemName: 'stockItem.itemName',
        quantityInCart: RxInt(0),
        price: 'N 20,000',
        totalItemPrice: ReceiptsController.instance.cartTotal.value,
        subTotal: RxDouble(0),
        discount: 0,
        tax: 0,
      ),
    );

    // Add the new category to the store's categories list
    store.sales.add(newSale);

    // Update the storeBox with the modified sale
    await storeBox.put(AddItemRepo.instance.currentStore.value, store);

    paymentMethod.text = paymentMood;
    amount.text = newSale.cart.totalItemPrice;
    dueDate.text = DateFormat('d MMM, yyyy').format(newSale.date);
    dueTime.text = DateFormat('hh:mm:ss a').format(newSale.date);

    // ReceiptFirebaseServices().saveNewSaleToDB(
    //     newSale: newSale,
    //     onSucess: () {
    //       print(
    //           'Receipt added to Firebase inside addNewSales in SalesController');
    //     });
  }

// get sales for a given date
  double getTotalSalesForToday(DateTime date) {
    // fetch store from storeBox
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

    DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    List<SalesModel> sales = store.sales.toList();

    RxDouble totalPrice = 0.0.obs;
    List<SalesModel> salesForDate = sales
        .where((sale) =>
            sale.date.isAfter(startOfDay) && sale.date.isBefore(endOfDay))
        .toList();
    if (salesForDate.isNotEmpty) {
      for (var sale in salesForDate) {
        totalPrice.value += double.parse(sale.cart.totalItemPrice);
        update();
      }
      DashBoardController.instance.todaySales.value = totalPrice.toString();
      update();
    } else {
      totalPrice.value = 0;
      update();
    }

    return totalPrice.value;
  }

  void setDatedSale(
    DateTime date,
  ) {
    // fetch store from storeBox
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
    );

    DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    List<SalesModel> sales = store.sales.toList();
    RxDouble totalPrice = 0.0.obs;

    List<SalesModel> salesForDate = sales
        .where((sale) =>
            sale.date.isAfter(startOfDay) && sale.date.isBefore(endOfDay))
        .toList();

    if (date == DateTime.now()) {
      return;
    }

    if (salesForDate.isEmpty) {
      getTotalSalesForToday(DateTime.now());
    } else {
      if (salesForDate.isNotEmpty) {
        for (var sale in salesForDate) {
          totalPrice.value += double.parse(sale.cart.totalItemPrice);
          update();
        }
        DashBoardController.instance.todaySales.value = totalPrice.toString();
        update();
      } else {
        totalPrice.value = 0;
        update();
      }
    }
  }
}
