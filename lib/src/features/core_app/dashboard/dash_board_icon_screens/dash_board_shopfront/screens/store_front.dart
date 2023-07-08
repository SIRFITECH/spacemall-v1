import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
// import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/application/store_front_controller.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';

class StoreFront extends StatelessWidget {
  const StoreFront({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final StoreRepo storeRepo = Get.find();

    final storeController = StoreController(storeRepo: storeRepo);

    return Scaffold(
      drawer: const SpacemallDrawer(),
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: "kStoreFrontAppBarText",
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
                    itemCount: storeController.stores.length,
                    itemBuilder: (context, index) {
                      final store = storeController.stores[index];
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            // StoreFrontController.removeCategory(index);
                            print('Remove store');
                          },
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.red,
                        ),
                        title: Text(
                          store.storeName,
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
                    controller: storeController.storeName,
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
                    storeController.addNewStoreToPhone();
                  },
                  child: const Text("kStoreFrontText"))
            ],
          ),
        ),
      ),
    );
  }
}
