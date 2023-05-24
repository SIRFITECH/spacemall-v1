import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/screens/add_stock_screen.dart';

class AddItemsCard extends StatelessWidget {
  const AddItemsCard({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: (() {
                  // var tapIndex = index;
                  if (index == 0) {
                    Get.to(
                      () => const AddStock(),
                    );
                  }
                }),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: index == 0 ? kMainColorLight : kWhiteLight,
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
                          left: 56,
                          bottom: 42,
                          child: GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(
                                    () => const AddStock(),
                                  );
                                  break;
                                case 1:
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const AddCategory()),
                                  // );
                                  debugPrint('$index add category');
                                  break;
                                case 2:
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const AddTag()),
                                  // );
                                  debugPrint('$index add tag');
                                  break;
                                case 3:
                                  debugPrint('$index add modifier');
                                  break;
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const AddStock()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kMainColorLight,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: const Icon(
                                Icons.add,
                                color: kWhiteLight,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              items[index],
                              style: index == 0
                                  ? const TextStyle(
                                      fontSize: 12, color: kWhiteLight)
                                  : const TextStyle(fontSize: 12),
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
