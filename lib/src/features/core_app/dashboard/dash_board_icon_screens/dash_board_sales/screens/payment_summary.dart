import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
// import '../../../../../../repository/hive_boxes.dart';
// import '../../../../store/domain/store_model.dart';
// import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/sales_controller.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({super.key});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    // StoreModel store = storeBox.get(
    //   AddItemRepo.instance.currentStore.value,
    //   defaultValue: StoreModel(
    //     logo: null,
    //     storeName: '',
    //     bankName: '',
    //     accountNumber: '',
    //     contact: '',
    //     stock: [],
    //     receipts: [],
    //     debts: [],
    //     staff: [],
    //     sales: [],
    //     customer: [],
    //     storeId: '',
    //     categories: [],
    //   ),
    // );

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kSalesPaymentSummaryText,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(kSalesItemText),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const AddToCart(),
                  //     ));
                },
                child: Container(
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      width: 2,
                      color: !isDarkMood
                          ? kTextFieldLightBorderColor
                          : kTextFieldDarkBorderColor.withOpacity(0.2),
                    ),
                  ),
                  padding: EdgeInsets.all(screenSize.height * 0.03),
                  child: const Column(
                    children: [Text(kSummaryOfItemsBoughtText)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SizedBox(
                  height: screenSize.height * 0.35,
                  child: ListView(
                    children: [
                      TextFeildWidget(
                        screenSize: screenSize,
                        isDarkMood: isDarkMood,
                        controller: SalesController.instance.paymentMethod,
                        keyboardType: TextInputType.text,
                        hintText: kSalesMEthodOfPaymentHintText,
                        labelText: kSalesMEthodOfPaymentText,
                        maxLines: 1,
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.9,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFeildWidget(
                        screenSize: screenSize,
                        isDarkMood: isDarkMood,
                        controller: SalesController.instance.amount,
                        keyboardType: TextInputType.number,
                        hintText: kSalesAmountHintText.toUpperCase(),
                        labelText: kSalesAmountText.toUpperCase(),
                        maxLines: 1,
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.9,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFeildWidget(
                            screenSize: screenSize,
                            isDarkMood: isDarkMood,
                            controller: SalesController.instance.dueDate,
                            keyboardType: TextInputType.datetime,
                            hintText: kSalesDateHintText.toUpperCase(),
                            labelText: kSalesDateText.toUpperCase(),
                            maxLines: 1,
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.4,
                          ),
                          TextFeildWidget(
                            screenSize: screenSize,
                            isDarkMood: isDarkMood,
                            controller: SalesController.instance.dueTime,
                            keyboardType: TextInputType.datetime,
                            hintText: kSalesTimeHintText.toUpperCase(),
                            labelText: kSalesTimeText.toUpperCase(),
                            maxLines: 1,
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.4,
                          ),
                        ],
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
