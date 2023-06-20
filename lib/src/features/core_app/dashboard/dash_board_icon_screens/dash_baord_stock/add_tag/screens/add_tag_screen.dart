import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_tag/application/add_tag_controller.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

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
      appBar: AppBar(
        title: const Text('Add Tag'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child:
                              //  variantPic == null
                              //     ?
                              CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                // Colors.transparent,
                                kDarkComplementColor.withOpacity(0.2),
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
                                  color: kMainColorLight,
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
                          )
                          // : CircleAvatar(
                          //     radius: 40,
                          //     backgroundImage: FileImage(variantPic!),
                          //   ),
                          ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add Photo'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Name',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addTagController.variantName,
                    keyboardType: TextInputType.text,
                    hintText: 'Drink',
                    labelText: '',
                    maxLines: 1,
                    height: MediaQuery.of(context).size.width * 0.135,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Select Name',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addTagController.item,
                    keyboardType: TextInputType.text,
                    hintText: '',
                    labelText: '',
                    maxLines: 1,
                    height: MediaQuery.of(context).size.width * 0.135,
                    width: MediaQuery.of(context).size.width * 0.90,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kMainColorLight,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(
                    Icons.add,
                    color: kWhiteLight,
                    size: 35,
                  ),
                ),
                const Text('Add More Items'),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Add Tag'))
          ],
        ),
      ),
    );
  }
}
