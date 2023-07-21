import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../repository/hive_boxes.dart';
import '../../../../store/domain/store_model.dart';
import '../../dash_baord_stock/add_item/data/add_item_repo.dart';

class RemainingStock extends StatefulWidget {
  const RemainingStock({super.key});

  @override
  State<RemainingStock> createState() => _RemainingStockState();
}

bool _showGrid = true;

class _RemainingStockState extends State<RemainingStock> {
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
          title: '$kReportRemainingStockText in ${store.storeName}',
          automaticallyImplyLeading: false),
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
            SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  side: BorderSide(
                    color: !isDarkMood
                        ? kTextFieldLightBorderColor.withOpacity(0.5)
                        : kTextFieldDarkBorderColor.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('20'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  side: BorderSide(
                    color: !isDarkMood
                        ? kTextFieldLightBorderColor.withOpacity(0.5)
                        : kTextFieldDarkBorderColor.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('35'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('45'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                    height: screenSize.height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.07,
                          decoration: BoxDecoration(
                              color: isDarkMood
                                  ? kTextFieldDarkBorderColor
                                  : kMainColorLight),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'SORT',
                                  style: TextStyle(color: kWhiteLight),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: kWhiteLight,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: screenSize.width * 0.1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: screenSize.width * 0.47,
                                  height: screenSize.height * 0.057,
                                  decoration: _showGrid
                                      ? BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(35),
                                            bottomLeft: Radius.circular(35),
                                          ),
                                          color: _showGrid
                                              ? isDarkMood
                                                  ? kTextFieldDarkBorderColor
                                                  : kLightModeDashboardAppbarColor
                                              : isDarkMood
                                                  ? kTransparentColor
                                                  : kWhiteLight,
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: _showGrid == false
                                                ? isDarkMood
                                                    ? kTextFieldDarkBorderColor
                                                    : kLightModeDashboardAppbarColor
                                                : isDarkMood
                                                    ? kTransparentColor
                                                    : kWhiteLight,
                                          ),
                                        ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showGrid = true;
                                      });
                                    },
                                    child: Text(
                                      'Low to High',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isDarkMood
                                            ? _showGrid
                                                ? kWhiteLight
                                                : kWhiteDark
                                            : _showGrid
                                                ? kWhiteLight
                                                : kBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                  child: Container(
                                width: screenSize.width * 0.47,
                                height: screenSize.height * 0.057,
                                decoration: _showGrid
                                    ? BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(35),
                                          bottomRight: Radius.circular(35),
                                        ),
                                        border: Border.all(
                                          color: _showGrid
                                              ? isDarkMood
                                                  ? kTextFieldDarkBorderColor
                                                  : kLightModeDashboardAppbarColor
                                              : isDarkMood
                                                  ? kTransparentColor
                                                  : kWhiteLight,
                                        ),
                                      )
                                    : BoxDecoration(
                                        color: _showGrid
                                            ? isDarkMood
                                                ? kTransparentColor
                                                : kWhiteLight
                                            : isDarkMood
                                                ? kTextFieldDarkBorderColor
                                                : kLightModeDashboardAppbarColor,
                                      ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showGrid = false;
                                    });
                                  },
                                  child: Text(
                                    'High to Low',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isDarkMood
                                          ? _showGrid
                                              ? kWhiteDark
                                              : kWhiteLight
                                          : _showGrid
                                              ? kBlack
                                              : kWhiteLight,
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 2.0,
                        //     vertical: screenSize.width * 0.1,
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(10),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Center(
                        //             child: ClipRRect(
                        //           borderRadius: const BorderRadius.only(
                        //             bottomLeft: Radius.circular(35),
                        //             topLeft: Radius.circular(35),
                        //           ),
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               color: kWhiteLight,
                        //               border: Border.all(
                        //                 width: 2,
                        //               ),
                        //               borderRadius: BorderRadius.circular(12.0),
                        //               boxShadow: const [
                        //                 BoxShadow(
                        //                     color: Colors.red,
                        //                     offset: Offset(2.0, 2.0),
                        //                     blurRadius: 100.0)
                        //               ],
                        //             ),
                        //             width: MediaQuery.of(context).size.width *
                        //                 0.47,
                        //             // color: kWhiteLight,
                        //             child: TextButton(
                        //               onPressed: () {
                        //                 // Navigator.push(
                        //                 //     context,
                        //                 //     MaterialPageRoute(
                        //                 //       builder: (context) => const AddModifierSuccess(),
                        //                 //     ));
                        //               },
                        //               child: const Text(
                        //                 'Low to High',
                        //                 style: TextStyle(
                        //                     fontSize: 15, color: kBlackDark),
                        //               ),
                        //             ),
                        //           ),
                        //         )),
                        //         Center(
                        //             child: ClipRRect(
                        //           borderRadius: const BorderRadius.only(
                        //             bottomRight: Radius.circular(35),
                        //             topRight: Radius.circular(35),
                        //           ),
                        //           child: Container(
                        //             width: MediaQuery.of(context).size.width *
                        //                 0.47,
                        //             color: kMainColorLight,
                        //             child: TextButton(
                        //               onPressed: () {
                        //                 // Navigator.push(
                        //                 //     context,
                        //                 //     MaterialPageRoute(
                        //                 //       builder: (context) => const AddModifierSuccess(),
                        //                 //     ));
                        //               },
                        //               child: const Text(
                        //                 'High to Low',
                        //                 style: TextStyle(
                        //                     fontSize: 15, color: kWhiteLight),
                        //               ),
                        //             ),
                        //           ),
                        //         )),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ));
        },
        backgroundColor:
            isDarkMood ? kTextFieldDarkBorderColor : kMainColorLight,
        child: const Icon(
          Icons.filter_alt_outlined,
          color: kWhiteLight,
        ),
      ),
    );
  }
}
