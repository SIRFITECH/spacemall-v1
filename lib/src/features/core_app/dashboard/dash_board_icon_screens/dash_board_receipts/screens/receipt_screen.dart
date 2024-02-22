import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/receipt_view.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../localizations/currency.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../dash_board_sales/application/sales_controller.dart';

class ReceiptListScreen extends StatelessWidget {
  const ReceiptListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final ReceiptsController receiptController = ReceiptsController();

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

    List<ReceiptsModel> receipstList = store.receipts.toList();

    receiptController.fromSelectedDate.value =
        DateFormat('d MMM').format(receiptController.fromDate.value);

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '${store.storeName} $kReceiptsAppBarText',
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.03,
                vertical: screenSize.height * 0.01,
              ),
              // the from and to clickable cards
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    width: screenSize.width * 0.47,
                    color: isDarkMood
                        ? kMainComplimemtColorLight
                        : kLightModeBackgroundColor,
                    child: TextButton(
                      onPressed: () async {
                        if (defaultTargetPlatform == TargetPlatform.iOS) {
                          DateTime selectedDate = await SalesController.instance
                              .pickiOSDate(context, 
                              // screenSize
                              );
                          // ignore: unnecessary_null_comparison
                          if (selectedDate != null) {
                            receiptController.fromSelectedDate.value =
                                DateFormat('d MMM').format(selectedDate);
                          } else {
                            receiptController.fromSelectedDate.value =
                                DateFormat('d MMM').format(DateTime.now());
                          }
                        } else {
                          DateTime selectedDate =
                              await SalesController.instance.pickDate(context);
                          // ignore: unnecessary_null_comparison
                          if (selectedDate != null) {
                            receiptController.fromSelectedDate.value =
                                DateFormat('d MMM').format(selectedDate);
                          } else {
                            receiptController.fromSelectedDate.value =
                                DateFormat('d MMM').format(DateTime.now());
                          }
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'From',
                            style: TextStyle(fontSize: 12, color: kWhiteLight),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.013,
                          ),
                          Obx(() => Text(
                                receiptController.fromDate.value ==
                                        DateTime.now()
                                            .subtract(const Duration(days: 7))
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(receiptController.lastWeekDate)
                                    : DateFormat('dd-MM-yyyy').format(
                                        receiptController.fromDate.value),
                                style: const TextStyle(
                                    fontSize: kBodyTextFont,
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.w900),
                              )),
                        ],
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: screenSize.width * 0.47,
                    color: isDarkMood
                        ? kMainComplimemtColorLight.withOpacity(0.5)
                        : kLightModeBackgroundColor.withOpacity(0.5),
                    child: TextButton(
                      // onPressed: () async {
                      //   if (defaultTargetPlatform == TargetPlatform.iOS) {
                      //     DateTime selectedDate = await SalesController.instance
                      //         .pickiOSDate(context, screenSize);
                      //     // ignore: unnecessary_null_comparison
                      //     if (selectedDate != null) {
                      //       receiptController.fromSelectedDate.value =
                      //           DateFormat('d MMM').format(selectedDate);
                      //     } else {
                      //       receiptController.fromSelectedDate.value =
                      //           DateFormat('d MMM').format(DateTime.now());
                      //     }
                      //   } else {
                      //     DateTime selectedDate =
                      //         await SalesController.instance.pickDate(context);
                      //     // ignore: unnecessary_null_comparison
                      //     if (selectedDate != null) {
                      //       receiptController.fromSelectedDate.value =
                      //           DateFormat('d MMM').format(selectedDate);
                      //     } else {
                      //       receiptController.fromSelectedDate.value =
                      //           DateFormat('d MMM').format(DateTime.now());
                      //     }
                      //   }
                      // },
                      onPressed: () {
                        receiptController.showCalendarAndSetToDate(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'To',
                            style: TextStyle(fontSize: 12, color: kWhiteLight),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.013,
                          ),
                          Obx(() => Text(
                                receiptController.selectedDateTime.value ==
                                        DateTime.now()
                                    ? DateFormat('dd-MM-yyyy').format(
                                        receiptController
                                            .selectedDateTime.value)
                                    : DateFormat('dd-MM-yyyy')
                                        .format(receiptController.toDate.value),
                                style: const TextStyle(
                                  fontSize: kBodyTextFont,
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.w900,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            // the body of the receipt screen
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  color: isDarkMood
                      ? kMainComplimemtColorLight.withOpacity(0.2)
                      : kLightModeBackgroundColor.withOpacity(0.2),
                  height: screenSize.height * 0.6,
                  child: Scrollbar(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: receipstList.length,
                        itemBuilder: (context, index) {
                          ReceiptsModel receipts = store.receipts[index];

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ReceiptView(
                                    receipt: receipts,
                                    parsedIndex: index,
                                  ));
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: screenSize.height * 0.1,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  side: BorderSide(
                                    color: !isDarkMood
                                        ? kTextFieldLightBorderColor
                                            .withOpacity(0.5)
                                        : kTextFieldDarkBorderColor
                                            .withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top:
                                                      screenSize.height * 0.015,
                                                ),
                                                child: Text(
                                                  receipts.customerName,
                                                  style: const TextStyle(
                                                    fontSize: kBodyTextFont,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${receipts.itemsInCart.length} item(s),',
                                                    style: const TextStyle(
                                                      fontSize: kBodyTextFont,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('d MMM, yyyy')
                                                        .format(
                                                      receipts.date,
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: kBodyTextFont,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenSize.height * 0.015),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nairaFormat.format(
                                                    double.parse(
                                                      receipts.cartTotal,
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: kBodyTextFont,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, bottom: 8),
                                                  child: Text(
                                                    'by ${receipts.paymentMethod}',
                                                    style: const TextStyle(
                                                      fontSize: kBodyTextFont,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
              child: SizedBox(
                width: screenSize.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // print(CartItemController.instance.updateItemState(1));
                    // print('Print to test');
                    // Get.to(
                    //   () => const ReceiptSettings(),
                    // );
                  },
                  child: const Text(
                    kReceiptsLoadMoreText,
                    style: TextStyle(
                      fontSize: kBodyTextFont,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
