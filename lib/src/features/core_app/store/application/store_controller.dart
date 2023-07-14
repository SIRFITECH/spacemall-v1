import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/domain/stock_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/domain/staff_model.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../constants/colors.dart';
import '../../dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';

class StoreController extends GetxController {
  StoreController({required this.storeRepo}) {
    storeRepo.storeController = this;
  }

  final StoreRepo storeRepo;
  static StoreController get instance => Get.put(
        StoreController(storeRepo: StoreRepo.instance),
      );
  // final AddItemRepo addItemRepo = AddItemRepo();

  // bool to indicate loading
  RxBool isLoading = false.obs;

  // check if store already exists
  RxBool isStoreAdded = false.obs;

// input data to create the store
  Rx<File?> logo = Rx<File?>(null);
  RxList<StockModel> stock = <StockModel>[].obs;
  RxList<ReceiptsModel> receipts = <ReceiptsModel>[].obs;
  RxList<DebtsModel> debts = <DebtsModel>[].obs;
  RxList<StaffModel> staff = <StaffModel>[].obs;
  RxList<SalesModel> sales = <SalesModel>[].obs;
  RxList<CustomerModel> customers = <CustomerModel>[].obs;
  final String uid = '';
  final TextEditingController storeName = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();

//  select and display logo
  void selectLogo(BuildContext context) async {
    logo.value = (await pickImage(context));
    update();
  }

  Rx<StoreModel?> selectedStore = Rx<StoreModel?>(
    null,
  );

  @override
  void onInit() {
    super.onInit();
  }

  RxList<StoreModel> stores = <StoreModel>[].obs;

// create a new store
  Future<void> addNewStoreToPhone() async {
    isLoading.value = true;
    storeRepo
        .saveStoreData()
        .then((value) => storeRepo.clearControllers())
        .then(
          (value) => Get.off(() => DashBoard()),
        );
    Get.snackbar(
      '${storeName.text.trim()} created',
      '${storeName.text.trim()} store created successfully',
      backgroundColor: kWhiteLight,
      colorText: kBlack,
    );
    isStoreAdded.value = true;

    isLoading.value = false;
  }

  // List myStores = storeBox.values.toList();

  void setStore(StoreModel? newValue) {
    if (newValue == null) {
      return;
    }

    if (stores.any((element) => element.storeName == newValue.storeName)) {
      Get.to(
        () => const AddStore(),
      );
      print('new store');
    } else {
      AddItemRepo.instance.currentStore.value = 'store-${newValue.storeId}';
      selectedStore.value = newValue;
      // StoreModel store = storeBox.get(
      //   // 'store-${newValue.storeId}',
      //   addItemRepo.currentStore.value,
      //   defaultValue: StoreModel(
      //     logo: null,
      //     storeName: '',
      //     bankName: '',
      //     accountNumber: '',
      //     contact: '',
      //     stock: [],
      //     receipts: [],
      //     debts: [],
      //     staff: [],
      //     sales: [],
      //     customer: [],
      //     storeId: '',
      //     categories: [],
      //   ),
      // );

      // print('${newValue.storeName} stock list ${newValue.stock}');
      // print(stores);
      // print(
      //   storeBox.get('store-${newValue.storeId}'),
      // );

      // print(store.storeName);
    }
  }

// add new store

  List<StoreModel> convertStores(List storesFromDb) {
    List<StoreModel> result = [];
    for (var item in storesFromDb) {
      StoreModel.fromMap(item);
    }
    return result;
  }

  List<CategoryModel> convertCategories(List<dynamic> categoriesFromDb) {
    List<CategoryModel> result = [];
    for (var category in categoriesFromDb) {
      result.add(category);
    }
    return result;
  }
}
