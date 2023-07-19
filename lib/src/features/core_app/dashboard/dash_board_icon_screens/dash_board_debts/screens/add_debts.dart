import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/application/debt_controller.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class AddToDebt extends StatelessWidget {
  const AddToDebt({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    DebtController debtController = Get.put(DebtController());

    // TextEditingController controller = TextEditingController();

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
        title: ' $kAddDebtToText ${store.storeName}',
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
          child: ListView(
            children: [
              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: debtController.nameController,
                keyboardType: TextInputType.name,
                hintText: '',
                labelText: kAddDebtNameText.toUpperCase(),
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),
              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: debtController.phoneController,
                keyboardType: TextInputType.phone,
                hintText: '',
                labelText: kAddDebtPhoneText.toUpperCase(),
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(kAddDebtItemsText.toUpperCase()),
              ),
              Container(
                width: screenSize.width * 0.9,
                height: screenSize.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                padding: EdgeInsets.all(screenSize.height * 0.01),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: debtController.debtItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          debtController.debtItems[index],
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: debtController.amountController,
                keyboardType: TextInputType.number,
                hintText: '',
                labelText: kAddDebtAmountText.toUpperCase(),
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: debtController.dueDateController,
                  keyboardType: TextInputType.datetime,
                  hintText: kDateHintText,
                  labelText: kAddDebtDueDateText.toUpperCase(),
                  maxLines: 1,
                  height: screenSize.height * 0.04,
                  width: screenSize.width * 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: ElevatedButton(
                      onPressed: () {
                        print(debtController.nameController.text);
                        print(debtController.phoneController.text);
                        print(debtController.amountController.text);
                        print(debtController.dueDateController.text);
                      },
                      child: Text(
                        kAddDebtAddText.toUpperCase(),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
