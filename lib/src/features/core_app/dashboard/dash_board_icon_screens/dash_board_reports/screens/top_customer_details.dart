import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

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
                                // ProfileController.instance.user!.createdAt,
                                DateFormat('d MMM, yyyy').format(
                                  DateTime.now().subtract(
                                    const Duration(days: 180),
                                  ),
                                ),
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
                                DateFormat('d MMM, yyyy').format(
                                  DateTime.now(),
                                ),
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
              // expandible container for more details about customer
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
                    ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: !isDarkMood
                            ? kMainColorLight
                            : kTextFieldDarkBorderColor.withOpacity(0.8),
                      ),
                      header: Text(
                        'More Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMood ? kGreyColor.shade600 : kBlackDark,
                        ),
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMood
                                          ? kGreyColor.shade700
                                          : kGreyColor.shade400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    truncateString(
                                        'adeoyefemi23@gmail.com', 15),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMood
                                          ? kGreyColor.shade600
                                          : kBlackDark,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMood
                                          ? kGreyColor.shade700
                                          : kGreyColor.shade400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    '+2340123456789',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMood
                                          ? kGreyColor.shade600
                                          : kBlackDark,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMood
                                  ? kGreyColor.shade700
                                  : kGreyColor.shade400,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkMood ? kGreyColor.shade600 : kBlackDark,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      collapsed: const Text(''),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // expandible container for orders
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
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    iconColor: !isDarkMood
                        ? kMainColorLight
                        : kTextFieldDarkBorderColor.withOpacity(0.8),
                  ),
                  header: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Orders(',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isDarkMood ? kGreyColor.shade600 : kBlackDark,
                          ),
                        ),
                        TextSpan(
                          text: '2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isDarkMood
                                ? kMainColorLight
                                : kTextFieldDarkBorderColor.withOpacity(0.8),
                          ),
                        ),
                        TextSpan(
                          text: ')',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isDarkMood ? kGreyColor.shade600 : kBlackDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  expanded: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          // screenSize.width * 0.5,
                          child: ListTile(
                            leading: Image.asset(
                              kTrialImage1,
                              width: 40,
                              height: 40,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2settle',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: isDarkMood
                                        ? kGreyColor.shade700
                                        : kGreyColor.shade400,
                                  ),
                                  // style: TextStyle(
                                  //   fontSize: 12,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '14 Items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMood
                                        ? kGreyColor.shade600
                                        : kBlackDark,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              DateFormat('d MMM, yyyy').format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: isDarkMood
                                    ? kGreyColor.shade700
                                    : kGreyColor.shade400,
                              ),
                            ),
                            trailing: Text(
                              'N 55,000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMood
                                    ? kGreyColor.shade600
                                    : kBlackDark,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.1,
                        indent: screenSize.width * 0.18,
                        thickness: 0.7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          // screenSize.width * 0.5,
                          child: ListTile(
                            leading: Image.asset(
                              kTrialImage1,
                              width: 40,
                              height: 40,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Transfer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: isDarkMood
                                        ? kGreyColor.shade700
                                        : kGreyColor.shade400,
                                  ),
                                  // style: TextStyle(
                                  //   fontSize: 12,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '3 Items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMood
                                        ? kGreyColor.shade600
                                        : kBlackDark,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              DateFormat('d MMM, yyyy').format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: isDarkMood
                                    ? kGreyColor.shade700
                                    : kGreyColor.shade400,
                              ),
                            ),
                            trailing: Text(
                              'N 300,000,000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMood
                                    ? kGreyColor.shade600
                                    : kBlackDark,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.1,
                        indent: screenSize.width * 0.18,
                        thickness: 0.7,
                      ),
                    ],
                  ),
                  collapsed: const Text(''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
