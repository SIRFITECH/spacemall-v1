import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class SalesController extends GetxController {
  static SalesController get instance => Get.find();

  DateTime now = DateTime.now();
  RxString date = ''.obs;

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

  Future<String> pickYesterday(BuildContext context) async {
    DateTime pickedDate = now;

    return date.value = DateFormat('d MMM').format(
      pickedDate.subtract(const Duration(days: 1)),
    );
  }

  Future<String> pickTommorow(BuildContext context) async {
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

    // fetch store from storeBox
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

    // Create a new sale
    SalesModel newSale = SalesModel(
      saleId: const Uuid().v4(),
      attendant: '',
      date: DateTime.now(),
      cart: CartItemModel(
        itemId: '',
        itemName: '',
        quantityInCart: 0,
        price: '',
        totalItemPrice: '',
        subTotal: 0,
        discount: 0,
        tax: 0,
      ),
    );
    // CategoryModel(
    //   categoryName: categoryName.text.trim(),
    //   itemId: '',
    //   categoryId: const Uuid().v4(),
    //   itemName: '',
    //   itemQuantity: '',
    // );

    // Add the new category to the store's categories list
    store.sales.add(newSale);

    // Update the storeBox with the modified sale
    await storeBox.put(AddItemRepo.instance.currentStore.value, store);
  }
}
