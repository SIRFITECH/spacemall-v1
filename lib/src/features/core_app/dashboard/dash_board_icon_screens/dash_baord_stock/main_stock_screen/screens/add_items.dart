import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/screens/add_category_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/screens/add_stock_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_modifier/screens/add_modifier_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_tag/screens/add_tag_screen.dart';

class AddItemsCard extends StatelessWidget {
  const AddItemsCard({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SizedBox(
          height: 70,
          width: screenSize.width,
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: (() {
                  if (index == 0) {
                    Get.to(
                      () => const AddStock(),
                    );
                  }
                }),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: screenSize.width * 0.21,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
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
                        Positioned(
                          left: screenSize.width * 0.135,
                          bottom: screenSize.height * 0.0475,
                          child: GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(
                                    () => const AddStock(),
                                  );
                                  break;
                                case 1:
                                  Get.to(
                                    () => const AddCategory(),
                                  );

                                  break;
                                case 2:
                                  Get.to(
                                    () => const AddTag(),
                                  );

                                  break;
                                case 3:
                                  Get.to(
                                    () => const AddModifier(),
                                  );

                                  break;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: index == 0
                                      ? isDarkMood
                                          ? kDarkModeDashboardAppbarColor
                                          : kMainColorLight
                                      : isDarkMood
                                          ? kBlack
                                          : kMainColorLight,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Icon(
                                Icons.add,
                                color: index == 0
                                    ? isDarkMood
                                        ? kDarkModeDashboardAppbarColor
                                        : kMainColorLight
                                    : kWhiteLight,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              items[index],
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
                ),
              );
            }),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
          )),
    );
  }
}
