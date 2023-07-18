import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/screens/shop_front_setting.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

// class StoreFront extends StatelessWidget {
//   const StoreFront({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     final brightness = media.platformBrightness;
//     final isDarkMood = brightness == Brightness.dark;
//     final screenSize = media.size;

//     final StoreRepo storeRepo = Get.find();

//     final storeController = StoreController(storeRepo: storeRepo);

//     return Scaffold(
//       drawer: const SpacemallDrawer(),
//       appBar: MyAppBar(
//         isDarkMood: isDarkMood,
//         title: "kStoreFrontAppBarText",
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//             image: AssetImage(kBackGroundCart),
//             fit: BoxFit.contain,
//           )),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: screenSize.height * 0.65,
//                 child: Obx(
//                   () => ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: storeController.stores.length,
//                     itemBuilder: (context, index) {
//                       final store = storeController.stores[index];
//                       return ListTile(
//                         leading: IconButton(
//                           onPressed: () {
//                             // StoreFrontController.removeCategory(index);
//                             print('Remove store');
//                           },
//                           icon: const Icon(Icons.remove_circle),
//                           color: Colors.red,
//                         ),
//                         title: Text(
//                           store.storeName,
//                           style: Theme.of(context).textTheme.labelSmall,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFeildWidget(
//                     screenSize: screenSize,
//                     isDarkMood: isDarkMood,
//                     controller: storeController.storeName,
//                     keyboardType: TextInputType.text,
//                     hintText: kHintText,
//                     labelText: kCategoryLabelText,
//                     maxLines: 1,
//                     height: screenSize.width * 0.135,
//                     width: screenSize.width * 0.90,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: screenSize.width * 0.1,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     storeController.addNewStoreToPhone();
//                   },
//                   child: const Text("kStoreFrontText"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ShopFrontScreen extends StatelessWidget {
  const ShopFrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kShopFrontAppBarText,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMood
                ? kDarkModeBackgroundColor.withAlpha(2)
                : kWhiteLight.withAlpha(2),
            image: const DecorationImage(
              image: AssetImage(kBackGroundCart),
              fit: BoxFit.contain,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: kMainColorLight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                            child: ClipOval(
                          child: Image.asset(kTrailImage3),
                        )),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Text('SIRFIMUNCH'),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(
                                  () => const AddStore(),
                                );
                              },
                              icon: const Icon(Icons.mode_edit_outlined),
                            )
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'share your website link with your customer and',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              softWrap: false,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'get online orders!',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              softWrap: false,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('https://sirfimunch.spacemall.io')
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: kMainColorLight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: screenSize.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            border:
                                Border.all(width: 1, color: kMainColorLight),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(kShopFrontCopyText),
                                Icon(Icons.copy_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: screenSize.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border:
                                Border.all(width: 1, color: kMainColorLight),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(kShopFrontShareText),
                                Icon(Icons.ios_share_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: screenSize.height,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const ShopFrontSettings());
                        },
                        child: const Text(kShopFrontLayoutsText)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
