import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bottom_nav_bar_screen.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class MallScreen extends StatelessWidget {
  const MallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    // final StockController stockController = Get.find();
    // final AddItemRepo addItemRepo = Get.find();

    TextEditingController controller = TextEditingController();

    // var values = ['Store', 'Products', 'Favourites'];

    // var items = [
    //   {
    //     "pic": "ItemPic",
    //     "name": "Name",
    //     "Vendor": "Seller",
    //   }
    // ];

    // List<List<String>> itemList = [];
    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'spacemallio',
        automaticallyImplyLeading: true,
      ),
      drawer: const SpacemallDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(kBackGroundCart),
          fit: BoxFit.contain,
        )),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            child: TextFeildWidget(
                                screenSize: screenSize,
                                isDarkMood: isDarkMood,
                                controller: controller,
                                keyboardType: TextInputType.text,
                                hintText:
                                    'Which store are you buying from today',
                                labelText: '',
                                maxLines: 1,
                                height: screenSize.height * 0.05,
                                width: screenSize.width * 0.8)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              print('Print help');
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.live_help_outlined,
                                  color: isDarkMood
                                      ? kDarkModeBrightIconColor
                                      : kDarkModeIconColor,
                                  size: 30,
                                ),
                                const Text('Help')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

/**
 *     // Card below the "Stock Managment" bold text
            // located in ...spacemall/spacemall/lib/widgets/componentWidgets/addvaluesCard.dart
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                  height: 40,
                  width: screenSize.width,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      // color: index == 0
                      //     ? isDarkMood
                      //         ? kDarkModeDashboardAppbarColor
                      //         : kMainColorLight
                      //     : kWhiteLight,
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: kBlackDark,
                      //     offset: Offset(1.0, 1.0),
                      //     blurRadius: 3.0,
                      //   ),
                      // ],
                    ),
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: (() {
                            if (index == 0) {
                              // Get.to(
                              //   () => const AddStock(),
                              // );
                              print('1 printed');
                            }
                          }),
                          child: Container(
                            width: screenSize.width * 0.3,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(4.0),
                              color: index == 0
                                  ? isDarkMood
                                      ? kDarkModeDashboardAppbarColor
                                      : kMainColorLight
                                  : kWhiteLight,
                              boxShadow: const [
                                BoxShadow(
                                    color: kBlackDark,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Positioned(
                                //   left: 56,
                                //   bottom: 42,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       switch (index) {
                                //         case 0:
                                //           // Get.to(
                                //           //   () => const AddStock(),
                                //           // );
                                //           break;
                                //         case 1:
                                //           // Get.to(
                                //           //   () => const AddCategory(),
                                //           // );
                                //           debugPrint('$index add category');
                                //           break;
                                //         case 2:
                                //           // Get.to(
                                //           //   () => const AddTag(),
                                //           // );
                                //           debugPrint('$index add tag');
                                //           break;
                                //         case 3:
                                //           // Get.to(
                                //           //   () => const AddModifier(),
                                //           // );
                                //           debugPrint('$index add modifier');
                                //           break;
                                //       }
                                //     },
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //           color: index == 0
                                //               ? isDarkMood
                                //                   ? kDarkModeDashboardAppbarColor
                                //                   : kMainColorLight
                                //               : isDarkMood
                                //                   ? kBlack
                                //                   : kMainColorLight,
                                //           borderRadius:
                                //               BorderRadius.circular(12.0)),
                                //       child: Icon(
                                //         Icons.add,
                                //         color: index == 0
                                //             ? isDarkMood
                                //                 ? kDarkModeDashboardAppbarColor
                                //                 : kMainColorLight
                                //             : kWhiteLight,
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      values[index],
                                      style: index == 0
                                          ? const TextStyle(
                                              fontSize: 12,
                                              color: kWhiteLight,
                                            )
                                          : const TextStyle(
                                              fontSize: 12,
                                              color: kDarkComplementColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      scrollDirection: Axis.horizontal,
                      itemCount: values.length,
                    ),
                  )),
            ),

            // stockBox.isNotEmpty
            //     ?
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: screenSize.height * 0.71,
              width: double.infinity,
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                    ),
                    itemCount: stockBox.length,
                    itemBuilder: (context, index) {
                      AddItemModel stockItem = stockBox.getAt(index);
                      return GestureDetector(
                        onTap: () {
                          var tapIndex = index;
                          if (index == tapIndex) {
                            debugPrint(stockItem.itemId);
                          }
                        },
                        child: Column(
                          children: [
                            Card(
                              color: kTransparentColor,
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 6),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor:
                                                    kMainComplimemtColorDark
                                                        .withOpacity(0.2),
                                                child: SizedBox(
                                                    child: ClipOval(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: stockItem.itemPic ==
                                                            null
                                                        ? SvgPicture.asset(
                                                            kImageIcon,
                                                            color:
                                                                kMainColorDark,
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )
                                                        : CircleAvatar(
                                                            radius: 60,
                                                            backgroundImage:
                                                                FileImage(stockItem
                                                                    .itemPic!),
                                                          ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    stockItem.itemName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isDarkMood
                                                            ? kWhiteLight
                                                            : kBlackDark,
                                                        fontSize: 19),
                                                  ),
                                                  Text(
                                                    stockItem.itemCategory,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isDarkMood
                                                          ? kGreyColor
                                                          : kBlackDark,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // Text(
                                            //   nairaFormat.format(int.parse(
                                            //       stockItem.valuesellingPrice)),
                                            //   style: const TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     color: kMainColorLight,
                                            //   ),
                                            // ),
                                            Text(
                                              "${stockItem.itemQuantity} in stock",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMood
                                                    ? kGreyColor
                                                    : kBlackDark,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    child:
                                        LoginDivider(height: 0, thickness: 3),
                                  ),
                                  // SizedBox(
                                  //   height: 30,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         left: 7, bottom: 5),
                                  //     child: ListView(
                                  //       scrollDirection: Axis.horizontal,
                                  //       children: [
                                  //         ElevatedButton(
                                  //           onPressed: () {},
                                  //           style: ElevatedButton.styleFrom(
                                  //             padding: const EdgeInsets.all(5),
                                  //           ),
                                  //           child: const Text('Small'),
                                  //         ),
                                  //         const SizedBox(
                                  //           width: 10,
                                  //         ),
                                  //         ElevatedButton(
                                  //           onPressed: () {},
                                  //           style: ElevatedButton.styleFrom(
                                  //             backgroundColor:
                                  //                 kLightModeInactiveButtonColor
                                  //                     .withOpacity(0.3),
                                  //             padding: const EdgeInsets.all(5),
                                  //           ),
                                  //           child: const Text('Meduim'),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          
 */