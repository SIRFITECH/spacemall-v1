import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../../repository/hive_boxes.dart';
import '../../../../../store/application/store_controller.dart';
import '../../../../../store/domain/store_model.dart';
import '../domain/category_model.dart';

class AddCategoryController extends GetxController {
  static AddCategoryController get instance => Get.find();
  final AddItemRepo addItemRepo = Get.put(AddItemRepo());
  late StoreController storeController;

  final TextEditingController categoryName = TextEditingController();

  int selectedIndex = 0;

  RxBool noCategory = true.obs;
  // category dropdown
  Rx<CategoryModel?> categoryValue = Rx<CategoryModel?>(
    null,
  );
  void setCategory(CategoryModel? newValue) {
    if (newValue?.categoryId == newValue?.categoryId) {
      categoryValue.value = newValue!;
    } else {
      Get.to(() => const AddCategory());
    }
  }

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // removeCategory(index) {
  //   Get.snackbar(
  //     '${categoryItems[index]} removed',
  //     '${categoryItems[index]} category removed successfully',
  //     backgroundColor: kWhiteLight,
  //     colorText: kBlack,
  //   );
  //   categoryItems.removeAt(index);
  // }

  addNewCategory() async {
    if (categoryName.text.isEmpty) {
      Get.snackbar(
        'Error',
        'You cannot add an empty category',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    } else {
      storeBox = await Hive.openBox<StoreModel>('store');

      // fetch store from storeBox
      StoreModel store = storeBox.get(
        AddItemRepo.instance.currentStore.value,
        defaultValue: StoreModel(
          logo: null,
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

      // Create a new category
      CategoryModel newCategory = CategoryModel(
        categoryName: categoryName.text.trim(),
        categoryId: const Uuid().v4(),
        items: RxList(),
        itemsInCategory: RxInt(0),
      );
      // Add the new category to the store's categories list
      store.categories.add(newCategory);

      // Update the storeBox with the modified store
      await storeBox.put(AddItemRepo.instance.currentStore.value, store);

      categories.add(newCategory);
      Get.back();
      categoryName.clear();
      Get.snackbar(
        '${categoryName.text} added',
        '${categoryName.text} category added successfully',
        backgroundColor: kWhiteLight,
        colorText: kBlack,
      );
    }
  }

// get categories
  List<CategoryModel> getCategoriesFromBox() {
    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logo: null,
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
