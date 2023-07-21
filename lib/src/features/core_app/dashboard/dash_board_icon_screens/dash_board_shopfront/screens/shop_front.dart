import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/screens/shop_front_setting.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class ShopFrontScreen extends StatelessWidget {
  const ShopFrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

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
    String urlString = 'https://spacemall.io/';

    final copyText = ClipboardData(text: urlString);

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kShopFrontAppBarText',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMood
                ? kDarkModeBackgroundColor.withAlpha(2)
                : kWhiteLight.withAlpha(2),
            image: DecorationImage(
              image: !isDarkMood
                  ? const AssetImage(kBackGroundCart)
                  : const AssetImage(kBackGroundCartDarkMood),
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
                Divider(
                  color:
                      !isDarkMood ? kMainColorLight : kMainComplimemtColorLight,
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
                              icon: Icon(
                                Icons.mode_edit_outlined,
                                size: 25,
                                color: !isDarkMood
                                    ? kMainComplimemtColorLight.withOpacity(0.8)
                                    : kMainColorLight.withOpacity(0.3),
                              ),
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
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'https://sirfimunch.spacemall.io',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: kWhiteLight
                                // !isDarkMood
                                //     ? kMainComplimemtColorLight.withOpacity(0.8)
                                //     : kMainColorLight.withOpacity(0.3),
                                ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Divider(
                  color:
                      !isDarkMood ? kMainColorLight : kMainComplimemtColorLight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(copyText).then(
                            (value) => Get.snackbar('Copy Successful',
                                'Store Link copied to clipboard'),
                          );
                        },
                        child: Container(
                          width: screenSize.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight
                                  : kMainComplimemtColorLight,
                            ),
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
                        onTap: () async {
                          await Share.share(urlString);
                        },
                        child: Container(
                          width: screenSize.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight
                                  : kMainComplimemtColorLight,
                            ),
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
