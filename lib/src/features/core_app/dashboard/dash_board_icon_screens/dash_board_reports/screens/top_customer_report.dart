import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/screens/top_customer_details.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/generic_dash_board_screens/linear_bar_indicator_widget.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class TopCustomerReport extends StatefulWidget {
  const TopCustomerReport({super.key});

  @override
  State<TopCustomerReport> createState() => _TopCustomerReportState();
}

class _TopCustomerReportState extends State<TopCustomerReport> {
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

    double percentage = 0.73;
    double percent = percentage * 100;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kReportCustomerReportText',
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const TopCustomerReportDetails(),
                  );
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const TopCustomerReportDetails(),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Customer',
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMood ? kWhiteLight : kBlackDark,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '65 orders',
                                style: TextStyle(
                                  color: kGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${percent.toInt().toString()}%'),
                              const Text('N 20,000'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: screenSize.width,
                            child: LinearBarIndicator(
                              isDarkMood: isDarkMood,
                              percentage: percentage,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
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
