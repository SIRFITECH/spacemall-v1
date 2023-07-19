import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../localizations/currency.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

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

    List<ReceiptsModel> receipstList = store.receipts.toList();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: '$kReceiptsAppBarText for ${store.storeName}',
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
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
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
                      onPressed: () {
                        receiptController.showCalendarAndSetFromDate(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'From',
                            style: TextStyle(fontSize: 12, color: kWhiteLight),
                          ),
                          const SizedBox(
                            height: 10,
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
                                    fontSize: 15, color: kWhiteLight),
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
                          const SizedBox(
                            height: 10,
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
                                    fontSize: 15, color: kWhiteLight),
                              )),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: isDarkMood
                        ? kMainComplimemtColorLight.withOpacity(0.2)
                        : kLightModeBackgroundColor.withOpacity(0.2),
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: receipstList.length,
                          itemBuilder: (context, index) {
                            ReceiptsModel receipts = store.receipts[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 8, right: 16, top: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        receipts.customerName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      Text(
                                        nairaFormat.format(
                                          double.parse(
                                            receipts.cartTotal,
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 8),
                                    child: Text(
                                      'by cash',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${receipts.itemsInCart} items',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('d MMM, yyyy').format(
                                          receipts.date,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: isDarkMood ? kBlack : kWhiteDark,
                                    height: 0.02,
                                    thickness: 0.7,
                                  ),
                                ],
                              ),
                            );
                          }),
                    )),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
              child: SizedBox(
                width: screenSize.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(
                    //   () => const ReceiptSettings(),
                    // );
                  },
                  child: const Text(
                    kReceiptsLoadMoreText,
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
