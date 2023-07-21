import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class TopCustomerReportDetails extends StatefulWidget {
  const TopCustomerReportDetails({super.key});

  @override
  State<TopCustomerReportDetails> createState() =>
      _TopCustomerReportDetailsState();
}

class _TopCustomerReportDetailsState extends State<TopCustomerReportDetails> {
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
        title: '${store.storeName} $kReportCustomerReportText',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: !isDarkMood
                          ? kMainColorLight.withOpacity(0.6)
                          : kTextFieldDarkBorderColor.withOpacity(0.8),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Member Since',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kGreyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '01 Jan 2023',
                                style: TextStyle(
                                  color: isDarkMood
                                      ? kGreyColor.shade600
                                      : kBlackDark,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Last Visited',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kGreyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '24 Jan 2023',
                                style: TextStyle(
                                  color: isDarkMood
                                      ? kGreyColor.shade600
                                      : kBlackDark,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'N100,000.00',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMood
                                      ? kGreyColor.shade600
                                      : kBlackDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: !isDarkMood
                        ? kMainColorLight.withOpacity(0.6)
                        : kTextFieldDarkBorderColor.withOpacity(0.8),
                  ),
                ),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'More Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isDarkMood ? kGreyColor.shade600 : kBlackDark,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 50,
                          color: !isDarkMood
                              ? kMainColorLight
                              : kTextFieldDarkBorderColor.withOpacity(0.8),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: !isDarkMood
                        ? kMainColorLight.withOpacity(0.6)
                        : kTextFieldDarkBorderColor.withOpacity(0.8),
                  ),
                ),
                padding: EdgeInsets.all(screenSize.height * 0.01),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Orders(',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMood
                                      ? kGreyColor.shade600
                                      : kBlackDark,
                                ),
                              ),
                              TextSpan(
                                text: '2',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: !isDarkMood
                                      ? kMainColorLight
                                      : kTextFieldDarkBorderColor
                                          .withOpacity(0.8),
                                ),
                              ),
                              TextSpan(
                                text: ')',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMood
                                      ? kGreyColor.shade600
                                      : kBlackDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 50,
                          color: !isDarkMood
                              ? kMainColorLight
                              : kTextFieldDarkBorderColor.withOpacity(0.8),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
