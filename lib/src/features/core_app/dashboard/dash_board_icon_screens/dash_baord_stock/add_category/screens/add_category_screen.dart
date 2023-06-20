import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';
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

    final addCategoryController = Get.put(
      AddCategoryController(),
    );
    return Scaffold(
      drawer: const SpacemallDrawer(),
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '',
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
                height: MediaQuery.of(context).size.width * 0.4,
                child: ListView(children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 32.0,
                      bottom: 16,
                    ),
                    child: Text('List of added Categories'),
                  )
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(
                        'Category Name',
                      ),
                    ),
                    TextFeildWidget(
                      screenSize: screenSize,
                      isDarkMood: isDarkMood,
                      controller: addCategoryController.categoryName,
                      keyboardType: TextInputType.text,
                      hintText: 'Drink',
                      labelText: '',
                      maxLines: 1,
                      height: MediaQuery.of(context).size.width * 0.135,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Add Category'))
            ],
          ),
        ),
      ),
    );
  }
}
