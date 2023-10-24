import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
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
  final AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  @override
  void onInit() {
    super.onInit();
    setInitialSelectedStore();
  }

  RxBool _noStoreYet = true.obs;

  RxBool _isLoading = false.obs;

  // check if store already exists
  RxBool isStoreAdded = false.obs;

  String _logoRemotePath = '';

  String _logoPicLocalPath = '';

  StoreModel? _store;

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
    setLogoPicLocalPath(logo.value!.path);
    update();
  }

  Rx<StoreModel?> selectedStore = Rx<StoreModel?>(
    null,
  );

// set the first store if there is a store in the phone
  void setInitialSelectedStore() {
    List<StoreModel> storesFromBox = StoreRepo.instance.getStoresFromBox();
    storesFromBox.isEmpty
        ? setStore(selectedStore.value)
        : setStore(storesFromBox.last);
  }

  Rx<StoreModel> selectedStoreValue = Rx<StoreModel>(
    StoreModel(
      logoLocalPath: '',
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
      logoRemotePath: '',
    ),
  );

  RxList<StoreModel> stores = <StoreModel>[].obs;

// create a new store
  Future<void> addNewStoreToPhone(BuildContext context) async {
    if (StoreController.instance.logo.value == null ||
        StoreController.instance.storeName.text == '') {
      Get.snackbar(
          'Bad Store', 'You can not add a store without logo or a name',
          backgroundColor: kRedColor, colorText: kWhiteLight);
    } else {
      isLoading.value = true;
      storeRepo.saveStore(context);
      Get.snackbar(
        '${storeName.text.trim()} created',
        '${storeName.text.trim()} store created successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
      isStoreAdded.value = true;

      isLoading.value = false;
    }
  }

  setStore(
    StoreModel? newValue,
  ) {
    if (newValue == null) {
      return;
    }

    if (stores.any((element) => element.storeName == newValue.storeName)) {
      Get.to(
        () => const AddStore(),
      );
    } else {
      AddItemRepo.instance.currentStore.value = 'store-${newValue.storeId}';
      selectedStore.value = newValue;
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

// shows if the store is open or not

  final storeStatus = true.obs;
  void storeStatusOpen(bool isOpen) {
    storeStatus(isOpen);
  }

  RxBool get noStoreYet => _noStoreYet;
  set setNoStoreYet(RxBool value) {
    _noStoreYet = value;
  }

  String get logoRemotePath => _logoRemotePath;

  void setLogoRemotePath(String value) {
    _logoRemotePath = value;
  }

  String get logoPicLocalPath => _logoPicLocalPath;

  void setLogoPicLocalPath(String value) {
    _logoPicLocalPath = value;
  }

  StoreModel? get store => _store;

  void setstore(StoreModel? value) {
    _store = value;
  }

  RxBool get isLoading => _isLoading;
  void setIsLoading(RxBool value) {
    _isLoading = value;
  }
}
