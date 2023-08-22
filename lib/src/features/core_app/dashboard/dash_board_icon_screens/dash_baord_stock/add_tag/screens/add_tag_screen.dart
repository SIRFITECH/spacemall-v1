import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_tag/application/add_tag_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class AddTag extends StatelessWidget {
  const AddTag({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final addTagController = Get.put(
      AddTagController(),
    );

    return Scaffold(
        appBar: MyAppBar(
            isDarkMood: isDarkMood,
            title: 'Add Tag',
            automaticallyImplyLeading: false),
        body: Obx(() {
          if (addTagController.isAlertShown.value == true) {
            dialogBox(
              isDarkMood,
              kComingSoonTitleText,
              kComingSoonBodyText,
              () => Stock(),
            );
            addTagController.isAlertShown.value = true;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 16),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // dialogBox(
                                        //   isDarkMood,
                                        //   kComingSoonTitleText,
                                        //   kComingSoonBodyText,
                                        //   () => const Stock(),
                                        // );
                                        // addTagController.isAlertShown.value =
                                        //     true;
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            // Colors.transparent,
                                            kDarkComplementColor
                                                .withOpacity(0.2),
                                        child: SizedBox(
                                            child: ClipOval(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: // check if the image placeholder is empty, get image from
                                                // sharedPreferences, otherwise, display the icon
                                                // variantPic == null
                                                //     ?
                                                SvgPicture.asset(
                                              kImageIcon,
                                              // ignore: deprecated_member_use
                                              color: isDarkMood
                                                  ? kDarkModeIconColor
                                                  : kMainColorLight,
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.scaleDown,
                                            )
                                            // : CircleAvatar(
                                            //     radius: 40,
                                            //     backgroundImage: NetworkImage(
                                            //       variantPic as String,
                                            //     ),
                                            //   )
                                            ,
                                          ),
                                        )),
                                      ),
                                    )
                                    // CircleAvatar(
                                    //     radius: 45,
                                    //     // backgroundImage: ,
                                    //     child: Image(
                                    //       height: 80,
                                    //       image: AssetImage(kBackGroundCart),
                                    //     ),
                                    //   ),
                                    ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  'Add Photo',
                                  // style: TextStyle(
                                  //     color: kBlack,
                                  //     fontSize: 23,
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Positioned(
                              left: 60,
                              bottom: 25,
                              child: GestureDetector(
                                onTap: () {
                                  // choose an image from photoss or camera
                                  // dialogBox(
                                  //   isDarkMood,
                                  //   kComingSoonTitleText,
                                  //   kComingSoonBodyText,
                                  //   () => const Stock(),
                                  // );
                                  // addTagController.isAlertShown.value = true;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMood
                                          ? kDarkModeIconColor
                                          : kMainColorLight,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: const Icon(
                                    Icons.add,
                                    color: kWhiteLight,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addTagController.variantName,
                    keyboardType: TextInputType.text,
                    hintText: '',
                    labelText: 'Name',
                    maxLines: 1,
                    height: MediaQuery.of(context).size.width * 0.135,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addTagController.item,
                    keyboardType: TextInputType.text,
                    hintText: '',
                    labelText: 'Select Item',
                    maxLines: 1,
                    height: MediaQuery.of(context).size.width * 0.135,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            dialogBox(
                              isDarkMood,
                              kComingSoonTitleText,
                              kComingSoonBodyText,
                              () => Stock(),
                            );
                            addTagController.isAlertShown.value = true;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: isDarkMood
                                    ? kDarkModeIconColor
                                    : kMainColorLight,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Icon(
                              Icons.add,
                              color: kWhiteLight,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Add More Items'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        dialogBox(
                          isDarkMood,
                          kComingSoonTitleText,
                          kComingSoonBodyText,
                          () => Stock(),
                        );
                        addTagController.isAlertShown.value = true;
                      },
                      child: const Text('Add Tag'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
