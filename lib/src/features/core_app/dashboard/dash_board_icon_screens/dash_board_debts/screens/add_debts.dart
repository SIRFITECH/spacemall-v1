import 'package:flutter/material.dart';
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

    TextEditingController controller = TextEditingController();

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
          image: const DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: controller,
                keyboardType: TextInputType.name,
                hintText: '',
                labelText: 'NAME',
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),

              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: controller,
                keyboardType: TextInputType.phone,
                hintText: '',
                labelText: 'PHONE',
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),

              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('ITEMS'),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                child: const Column(
                  children: [Text('   ')],
                ),
              ),

              TextFeildWidget(
                screenSize: screenSize,
                isDarkMood: isDarkMood,
                controller: controller,
                keyboardType: TextInputType.number,
                hintText: '',
                labelText: 'AMOUNT',
                maxLines: 1,
                height: screenSize.height * 0.045,
                width: screenSize.width * 0.95,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'DUE DATE',
                  //style: kHeaderThreeTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'ADD',
                      )),
                ),
              )

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //           vertical: MediaQuery.of(context).size.height * 0.02),
              //       child: Center(
              //           child: ClipRRect(
              //         borderRadius: BorderRadius.circular(6),
              //         child: Container(
              //           width: 150,
              //           color: kMainColorLight,
              //           child: TextButton(
              //             onPressed: () {
              //               // Navigator.push(
              //               //     context,
              //               //     MaterialPageRoute(
              //               //       builder: (context) => const AddModifierSuccess(),
              //               //     ));
              //             },
              //             child: const Text(
              //               'ADD',
              //               style: TextStyle(fontSize: 15, color: kWhiteLight),
              //             ),
              //           ),
              //         ),
              //       )),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
