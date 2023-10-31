import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/screens/payment_summary.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';
import '../application/sales_controller.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    SalesController salesController = Get.put(
      SalesController(),
    );
    salesController.date.value = DateFormat('d MMM').format(DateTime.now());

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

    List<SalesModel> salesList = store.sales.toList();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kSalesAppBarText,
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              child: Center(
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: !isDarkMood
                          ? kTextFieldLightBorderColor.withOpacity(0.5)
                          : kTextFieldDarkBorderColor.withOpacity(0.5),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(screenSize.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            salesController.pickYesterday(
                              context,
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (defaultTargetPlatform == TargetPlatform.iOS) {
                              DateTime selectedDate = await salesController
                                  .pickiOSDate(context, screenSize);
                              // ignore: unnecessary_null_comparison
                              if (selectedDate != null) {
                                salesController.date.value =
                                    DateFormat('d MMM').format(selectedDate);
                              } else {
                                salesController.date.value =
                                    DateFormat('d MMM').format(DateTime.now());
                              }
                            } else {
                              DateTime selectedDate =
                                  await salesController.pickDate(context);
                              // ignore: unnecessary_null_comparison
                              if (selectedDate != null) {
                                salesController.date.value =
                                    DateFormat('d MMM').format(selectedDate);
                              } else {
                                salesController.date.value =
                                    DateFormat('d MMM').format(DateTime.now());
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: !isDarkMood
                                    ? kTextFieldLightBorderColor
                                    : kTextFieldDarkBorderColor
                                        .withOpacity(0.5),
                              ),
                              Obx(
                                () => Text(
                                  ' $kReportTodayText : ${salesController.date.value} ',
                                  style: const TextStyle(
                                    color: kGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          color: !isDarkMood
                              ? kBlackDark.withOpacity(0.5)
                              : kTextFieldDarkBorderColor.withOpacity(0.5),
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                          ),
                          onPressed: () {
                            salesController.pickTommorow(
                              context,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.75,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: salesList.isNotEmpty
                    ? ListView.builder(
                        itemCount: salesList.length,
                        itemBuilder: (context, index) {
                          // String totalItemPrice = salesList[index]
                          //     .cart
                          //     .totalItemPrice
                          //     .replaceAll(RegExp(r'[^0-9]'), '');
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const PaymentSummary(),
                              );
                              if (salesList.isNotEmpty) {
                                // print(salesList[index]
                                //     .customerName
                                //     .substring(0, 1));
                              } else {
                                // print('No item');
                              }
                            },
                            child: Column(
                              children: [
                                Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height:
                                                      screenSize.height * 0.06,
                                                  width:
                                                      screenSize.width * 0.12,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: !isDarkMood
                                                          ? kMainColorLight
                                                              .withOpacity(0.6)
                                                          : kMainComplimemtColorLight
                                                              .withOpacity(0.8),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                ClipOval(
                                                  child: Container(
                                                    height: screenSize.height *
                                                        0.06,
                                                    width:
                                                        screenSize.width * 0.12,
                                                    color: Colors.transparent,
                                                    child: Center(
                                                      child: Text(
                                                        salesList[index]
                                                            .customerName
                                                            .substring(0, 1),
                                                        style: TextStyle(
                                                          fontSize: 45,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: !isDarkMood
                                                              ? kMainColorLight
                                                                  .withOpacity(
                                                                      0.6)
                                                              : kMainComplimemtColorLight
                                                                  .withOpacity(
                                                                      0.8),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  salesList[index].customerName,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    // Text(
                                                    //   nairaFormat.format(
                                                    //     double.parse(
                                                    //         totalItemPrice),
                                                    //   ),
                                                    //   style: const TextStyle(
                                                    //     fontSize: 15,
                                                    //     fontWeight:
                                                    //         FontWeight.bold,
                                                    //   ),
                                                    // ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Sold on ${DateFormat('d MMM, yyyy').format(salesList[index].date)}',
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        })
                    : const Center(
                        child: Text('You have not made a Sale today'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
