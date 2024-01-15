import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../../constants/colors.dart';
import '../../../../../../../repository/hive_boxes.dart';
import '../../../../../store/application/store_controller.dart';
import '../../../../../store/domain/store_model.dart';
import '../data/add_category_repo.dart';
import '../domain/category_model.dart';

class AddCategoryController extends GetxController {
  static AddCategoryController get instance => Get.find();
  final AddItemRepo addItemRepo = Get.find();

  final AddCategoryRepo _addCategoryRepo = Get.put(AddCategoryRepo());

  late StoreController storeController;
  RxBool isLoading = false.obs;

  final TextEditingController categoryName = TextEditingController();

  int selectedIndex = 0;

  RxBool noCategory = true.obs;

  // category dropdown
  Rx<CategoryModel?> categoryValue = Rx<CategoryModel?>(null
      // CategoryModel(
      //   categoryName: '',
      //   categoryId: '',
      //   items: RxList<AddItemModel>([
      //     AddItemModel(
      //       itemPic: null,
      //       itemName: '',
      //       itemSellingPrice: '',
      //       itemCategory: '',
      //       itemQuantity: '',
      //       itemCostPrice: '',
      //       trackProfit: false,
      //       trackLowStock: false,
      //       preventItemSalesWhenOutOfStock: false,
      //       trackExpiry: '',
      //       expiryAlert: '',
      //       itemCount: 0,
      //       itemId: '',
      //       morePics: RxList<File>(),
      //     ),
      //   ]),
      //   itemsInCategory: 0,
      // ),
      );

  void setCategory(CategoryModel? newValue) {
    if (newValue?.categoryId == newValue?.categoryId) {
      categoryValue.value = newValue!;
    } else {
      Get.to(() => const AddCategory());
    }
  }

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

// add category
  Future addNewCategory(BuildContext context) async {
    CategoryModel newCategory = CategoryModel(
      categoryName: categoryName.text.trim(),
      categoryId: const Uuid().v4(),
      items: RxList([]),
      itemsInCategory: 0,
    );

    if (categoryName.text.isEmpty) {
      spaceMallSnackBar(
        'Error Adding Categrory',
        'You cannot add an empty category',
        kWhiteLight,
        kRedColor,
      );
    } else {
      _addCategoryRepo.saveCategory(context, newCategory);
    }
  }

// remove category by index
  removeCategory(int categoryIndex) {
    final StoreModel store = storeBox.get(
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

    if (store.categories.isEmpty) {
      spaceMallSnackBar(
        'Error Deleting Categrory',
        'You cannot a category that does not exist',
        kWhiteLight,
        kRedColor,
      );
    } else {
      _addCategoryRepo.removeCategory(categoryIndex);
    }
  }

// get categories
  List<CategoryModel> getCategoriesFromBox() {
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
    List<CategoryModel> categoryList = [];

    // for (var key in storeBox.keys) {
    //   if (key.startsWith('store-')) {
    //     StoreModel? store = storeBox.get(key);
    //     if (store != null) {
    //       categoryList.addAll(store.categories);
    //     }
    //   }
    // }
    categoryList.addAll(store.categories);
    return categoryList;
  }
}
