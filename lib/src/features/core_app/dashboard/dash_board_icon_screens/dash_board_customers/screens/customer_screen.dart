import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

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
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kCustomerAppBarText',
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.12,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kTextFieldLightBorderColor
                                                      .withOpacity(0.5)
                                                  : kTextFieldDarkBorderColor
                                                      .withOpacity(0.5),
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        ClipOval(
                                          child: Container(
                                            height: screenSize.height * 0.06,
                                            width: screenSize.width * 0.12,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Text(
                                                'O',
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight: FontWeight.bold,
                                                    color: !isDarkMood
                                                        ? kTextFieldLightBorderColor
                                                        : kTextFieldDarkBorderColor
                                                            .withOpacity(0.5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Osagie ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMood
                                                  ? kWhiteLight
                                                  : kBlackDark,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '0812345678',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: kGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'TOTAL ORDER',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMood
                                                ? kGreyColor
                                                : kBlackDark,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: screenSize.width * 0.2,
                                          decoration: BoxDecoration(
                                            color: !isDarkMood
                                                ? kMainColorLight
                                                : kTextFieldDarkBorderColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kMainColorLight
                                                  : kTextFieldDarkBorderColor,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                '15',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: kWhiteLight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'LAST ORDER',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMood
                                                ? kGreyColor
                                                : kBlackDark,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            color: !isDarkMood
                                                ? kMainColorLight
                                                : kTextFieldDarkBorderColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kMainColorLight
                                                  : kTextFieldDarkBorderColor,
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              '2 DAYS AGO',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteLight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.12,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kTextFieldLightBorderColor
                                                      .withOpacity(0.5)
                                                  : kTextFieldDarkBorderColor
                                                      .withOpacity(0.5),
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        ClipOval(
                                          child: Container(
                                            height: screenSize.height * 0.06,
                                            width: screenSize.width * 0.12,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Text(
                                                'F',
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight: FontWeight.bold,
                                                    color: !isDarkMood
                                                        ? kTextFieldLightBorderColor
                                                        : kTextFieldDarkBorderColor
                                                            .withOpacity(0.5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Femi ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMood
                                                  ? kWhiteLight
                                                  : kBlackDark,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            '0812345678',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: kGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'TOTAL ORDER',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMood
                                                ? kGreyColor
                                                : kBlackDark,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: screenSize.width * 0.2,
                                          decoration: BoxDecoration(
                                            color: !isDarkMood
                                                ? kMainColorLight
                                                : kTextFieldDarkBorderColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kMainColorLight
                                                  : kTextFieldDarkBorderColor,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                '15',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: kWhiteLight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'LAST ORDER',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMood
                                                ? kGreyColor
                                                : kBlackDark,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            color: !isDarkMood
                                                ? kMainColorLight
                                                : kTextFieldDarkBorderColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                              width: 1,
                                              color: !isDarkMood
                                                  ? kMainColorLight
                                                  : kTextFieldDarkBorderColor,
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              '2 DAYS AGO',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteLight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
