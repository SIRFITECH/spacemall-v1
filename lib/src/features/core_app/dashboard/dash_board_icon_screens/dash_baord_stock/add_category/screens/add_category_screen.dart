import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final AddCategoryController addCategoryController = Get.find();

    return Scaffold(
      drawer: const SpacemallDrawer(),
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kAddCategoryAppBarText,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          )),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: addCategoryController.categoryItems.length,
                    itemBuilder: (context, index) {
                      final category =
                          addCategoryController.categoryItems[index];
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            addCategoryController.removeCategory(index);
                          },
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.red,
                        ),
                        title: Text(
                          category,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    },
                  ),
                ),
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
                    height: MediaQuery.of(context).size.width * 0.135,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              ElevatedButton(
                  onPressed: () {
                    // print(addCategoryController.categoryName.text.trim());
                    addCategoryController.addNewCategory();
                  },
                  child: const Text(kAddCategoryText))
            ],
          ),
        ),
      ),
    );
  }
}
