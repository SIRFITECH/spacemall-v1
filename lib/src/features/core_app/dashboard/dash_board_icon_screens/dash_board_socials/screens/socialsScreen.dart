import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class SocialsScreen extends StatefulWidget {
  const SocialsScreen({super.key});

  @override
  State<SocialsScreen> createState() => _SocialsState();
}

class _SocialsState extends State<SocialsScreen> {
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

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kSocialsAppBarText',
        automaticallyImplyLeading: false,
      ),
      body: Container(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SizedBox(
                  height: screenSize.height * 0.7,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight.withOpacity(0.6)
                                  : kMainComplimemtColorLight.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            leading: const Image(
                              height: 35,
                              image: AssetImage(kTwitterLogin),
                            ),
                            title: Text(
                              'Twitter',
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight.withOpacity(0.6)
                                  : kMainComplimemtColorLight.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            leading: const Image(
                              height: 35,
                              image: AssetImage(kFaceBookLogin),
                            ),
                            title: Text(
                              'Facebook',
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
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
                                  : kMainComplimemtColorLight.withOpacity(0.8),
                            ),
                          ),
                          child: ListTile(
                            leading: const Image(
                              height: 35,
                              image: AssetImage(kInstagramLogin),
                            ),
                            title: Text(
                              'Instagram',
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text(kAddSocialText)),
                        ],
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
