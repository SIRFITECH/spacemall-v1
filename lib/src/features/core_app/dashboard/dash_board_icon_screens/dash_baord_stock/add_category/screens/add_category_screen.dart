import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';

import '../../../../../../../repository/hive_boxes.dart';
import '../../../../../store/domain/store_model.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final AddCategoryController addCategoryController = Get.find();

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

    return Scaffold(
      drawer: const SpacemallDrawer(),
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '$kAddCategoryAppBarText to ${store.storeName}',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            color: isDarkMood
                ? kDarkModeBackgroundColor.withOpacity(0.020)
                : kWhiteLight.withOpacity(0.1),
            height: screenSize.height * 0.85,
            child: GetBuilder<StoreController>(
              builder: (storeController) {
                if (storeController.stores.isEmpty &&
                    storeController.noStoreYet.value == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.defaultDialog(
                      backgroundColor: !isDarkMood
                          ? kDarkModeBackgroundColor.withOpacity(0.1)
                          : kWhiteDark.withOpacity(0.1),
                      title: kAddStoreText,
                      titleStyle: const TextStyle(
                        color: kWhiteLight,
                      ),
                      content: const Text(
                        kAddStoreAlertBodyText,
                        style: TextStyle(
                          color: kWhiteLight,
                        ),
                      ),
                      confirm: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddStore());
                        },
                        child: const Text(kOkayText),
                      ),
                    );
                  });
                  addCategoryController.noCategory.value = false;
                }

                return Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.025),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: !isDarkMood
                              ? const AssetImage(kBackGroundCart)
                              : const AssetImage(kBackGroundCartDarkMood),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.65,
                            child:
                                //  Obx(
                                //   () =>
                                ListView.builder(
                              shrinkWrap: true,
                              itemCount: store.categories.length,
                              itemBuilder: (context, index) {
                                final category = store.categories[index];
                                return ListTile(
                                  leading: IconButton(
                                    onPressed: () {
                                      // print('Delete from category');
                                      // addCategoryController.removeCategory(index);
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                    color: kRedColor,
                                  ),
                                  title: Text(
                                    category.categoryName,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                );
                              },
                            ),
                            // ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFeildWidget(
                                screenSize: screenSize,
                                isDarkMood: isDarkMood,
                                controller: addCategoryController.categoryName,
                                keyboardType: TextInputType.text,
                                hintText: kHintText,
                                labelText: kCategoryLabelText,
                                maxLines: 1,
                                height: screenSize.width * 0.135,
                                width: screenSize.width * 0.90,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                addCategoryController.addNewCategory();
                              },
                              child: const Text(kAddCategoryText))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),

      // SingleChildScrollView(
      //   child: Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: !isDarkMood
      //             ? const AssetImage(kBackGroundCart)
      //             : const AssetImage(kBackGroundCartDarkMood),
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: screenSize.height * 0.65,
      //           child:
      //               //  Obx(
      //               //   () =>
      //               ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: store.categories.length,
      //             itemBuilder: (context, index) {
      //               final category = store.categories[index];
      //               return ListTile(
      //                 leading: IconButton(
      //                   onPressed: () {
      //                     // print('Delete from category');
      //                     // addCategoryController.removeCategory(index);
      //                   },
      //                   icon: const Icon(Icons.remove_circle),
      //                   color: kRedColor,
      //                 ),
      //                 title: Text(
      //                   category.categoryName,
      //                   style: Theme.of(context).textTheme.labelSmall,
      //                 ),
      //               );
      //             },
      //           ),
      //           // ),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             TextFeildWidget(
      //               screenSize: screenSize,
      //               isDarkMood: isDarkMood,
      //               controller: addCategoryController.categoryName,
      //               keyboardType: TextInputType.text,
      //               hintText: kHintText,
      //               labelText: kCategoryLabelText,
      //               maxLines: 1,
      //               height: screenSize.width * 0.135,
      //               width: screenSize.width * 0.90,
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: MediaQuery.of(context).size.width * 0.1,
      //         ),
      //         ElevatedButton(
      //             onPressed: () {
      //               addCategoryController.addNewCategory();
      //             },
      //             child: const Text(kAddCategoryText))
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
