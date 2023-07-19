import 'package:flutter/material.dart';
import 'package:spacemall/src/common_widgets/common_widgets.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/screens/add_debts.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/screens/debt_summary.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../general/my_app_bar.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key});

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
        title: '$kDebtAppBarText for ${store.storeName}',
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
        child: Scrollbar(
          child: ListView(
            children: [
              SizedBox(
                height: screenSize.height * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DebtSummary(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight
                                  : kMainComplimemtColorLight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16),
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
                                                  ? kMainColorLight
                                                      .withOpacity(0.6)
                                                  : kMainComplimemtColorLight
                                                      .withOpacity(
                                                          0.8), // Replace with your desired border color
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
                                                'N',
                                                style: TextStyle(
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.bold,
                                                  color: !isDarkMood
                                                      ? kMainColorLight
                                                          .withOpacity(0.6)
                                                      : kMainComplimemtColorLight
                                                          .withOpacity(0.8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'New Customer',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '- N20,000',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '6 days remaining',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: !isDarkMood
                                      ? kMainColorLight
                                      : kMainComplimemtColorLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const DebtSummary(),
                      //         ));
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(
                      //         width: 1,
                      //         color: !isDarkMood
                      //             ? kMainColorLight
                      //             : kMainComplimemtColorLight,
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 10.0, horizontal: 16),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Stack(
                      //                 children: [
                      //                   Container(
                      //                     height: screenSize.height * 0.06,
                      //                     width: screenSize.width * 0.12,
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       color: !isDarkMood
                      //                           ? kMainColorLight
                      //                               .withOpacity(0.6)
                      //                           : kMainComplimemtColorLight
                      //                               .withOpacity(0.8),
                      //                     ),
                      //                   ),
                      //                   CustomPaint(
                      //                     size: const Size(35, 35),
                      //                     painter: ShapePainter(),
                      //                     child: Container(
                      //                       height: screenSize.height * 0.06,
                      //                       width: screenSize.width * 0.12,
                      //                       color: Colors.transparent,
                      //                       child: const Center(
                      //                         child: Text(
                      //                           'N',
                      //                           style: TextStyle(
                      //                             fontSize: 45,
                      //                             fontWeight: FontWeight.bold,
                      //                             color: Colors.white,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ), // CustomPainter class for your custom shape
                      //                   ),
                      //                   // ClipOval(
                      //                   //   child:
                      //                   // ),
                      //                 ],
                      //               ),
                      //               // Stack(
                      //               //   children: [
                      //               //     Container(
                      //               //       height: screenSize.height * 0.06,
                      //               //       width: screenSize.width * 0.12,
                      //               //       decoration: BoxDecoration(
                      //               //         shape: BoxShape.circle,
                      //               //         color: !isDarkMood
                      //               //             ? kMainColorLight
                      //               //                 .withOpacity(0.6)
                      //               //             : kMainComplimemtColorLight
                      //               //                 .withOpacity(0.8),
                      //               //       ),
                      //               //     ),
                      //               //     ClipOval(
                      //               //       child: Container(
                      //               //         height: screenSize.height * 0.06,
                      //               //         width: screenSize.width * 0.12,
                      //               //         color: Colors.transparent,
                      //               //         child: const Center(
                      //               //           child: Text(
                      //               //             'N',
                      //               //             style: TextStyle(
                      //               //               fontSize: 45,
                      //               //               fontWeight: FontWeight.bold,
                      //               //               color: Colors.white,
                      //               //             ),
                      //               //           ),
                      //               //         ),
                      //               //       ),
                      //               //     ),
                      //               //   ],
                      //               // ),

                      //               const SizedBox(
                      //                 width: 15,
                      //               ),
                      //               const Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     'New Customer',
                      //                     style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                   Text(
                      //                     '- N20,000',
                      //                     style: TextStyle(
                      //                       fontSize: 17,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 10,
                      //                   ),
                      //                   Text(
                      //                     '6 days remaining',
                      //                     style: TextStyle(fontSize: 12),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward,
                      //             color: !isDarkMood
                      //                 ? kMainColorLight
                      //                 : kMainComplimemtColorLight,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DebtSummary(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: !isDarkMood
                                  ? kMainColorLight
                                  : kMainComplimemtColorLight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16),
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
                                                  ? kMainColorLight
                                                      .withOpacity(0.6)
                                                  : kMainComplimemtColorLight
                                                      .withOpacity(
                                                          0.8), // Replace with your desired border color
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
                                                      ? kMainColorLight
                                                          .withOpacity(0.6)
                                                      : kMainComplimemtColorLight
                                                          .withOpacity(0.8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Osagie David',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '- N50,000',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '6 days remaining',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: !isDarkMood
                                      ? kMainColorLight
                                      : kMainComplimemtColorLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddToDebt(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: clickableText(
                                  isDarkMood: isDarkMood, text: kAddDebtorText),
                            ),
                          ),
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
