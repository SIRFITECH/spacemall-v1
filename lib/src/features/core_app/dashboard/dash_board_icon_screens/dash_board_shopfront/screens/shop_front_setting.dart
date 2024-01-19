import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';

class ShopFrontSettings extends StatefulWidget {
  const ShopFrontSettings({super.key});

  @override
  State<ShopFrontSettings> createState() => _ShopFrontSettingsState();
}

class _ShopFrontSettingsState extends State<ShopFrontSettings> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

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

    // bool clicked = false;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kShopFrontSettingsAppBarText',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: screenSize.height * 0.7,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight.withOpacity(0.6)
                                  : kTextFieldDarkBorderColor.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              'Show home screen',
                              style: TextStyle(
                                fontSize: kHeaderTextFontSmall,
                                fontWeight: FontWeight.w900,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            subtitle: Text(
                              'banners, category, group items',
                              style: TextStyle(
                                fontSize: kBodyTextFont,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                print('toggle clicked');
                              },
                              icon: Icon(
                                Icons.toggle_off_outlined,
                                size: 50,
                                color:
                                    // clicked ?
                                    !isDarkMood
                                        ? kMainColorLight.withOpacity(0.6)
                                        : kTextFieldDarkBorderColor
                                            .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight.withOpacity(0.6)
                                  : kTextFieldDarkBorderColor.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              'Show cover screen',
                              style: TextStyle(
                                fontSize: kHeaderTextFontSmall,
                                fontWeight: FontWeight.w900,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            subtitle: Text(
                              'Group all varients or sub items as single item with options',
                              style: TextStyle(
                                fontSize: kBodyTextFont,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.toggle_on,
                                size: 50,
                                color: !isDarkMood
                                    ? kMainColorLight.withOpacity(0.6)
                                    : kTextFieldDarkBorderColor
                                        .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight.withOpacity(0.6)
                                  : kTextFieldDarkBorderColor.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              'Enable item grouping',
                              style: TextStyle(
                                fontSize: kHeaderTextFontSmall,
                                fontWeight: FontWeight.w900,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            subtitle: Text(
                              'Group all varients or sub items as single item with options',
                              style: TextStyle(
                                fontSize: kBodyTextFont,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.toggle_off_outlined,
                                size: 50,
                                color:
                                    // clicked ?
                                    !isDarkMood
                                        ? kMainColorLight.withOpacity(0.6)
                                        : kTextFieldDarkBorderColor
                                            .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                          width: screenSize.height * 0.15,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                () => const ShopFrontSettings(),
                              );
                            },
                            child: const Text(
                              kSaveText,
                              style: TextStyle(
                                fontSize: kBodyTextFont,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
