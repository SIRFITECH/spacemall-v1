import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_modifier/application/add_modifier_controller.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class AddModifier extends StatelessWidget {
  const AddModifier({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final addModifierController = Get.put(
      AddModifierController(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Modifier'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CircleAvatar(
                        radius: 45,
                        child: Image(
                          height: 80,
                          image: AssetImage(kBackGroundCart),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Add Picture',
                      style: TextStyle(
                          color: kBlack,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Positioned(
                  left: 85,
                  bottom: 36,
                  child: GestureDetector(
                    onTap: () {
                      // choose an image from photoss or camera
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kMainColorLight,
                          borderRadius: BorderRadius.circular(12.0)),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: TextFeildWidget(
                    screenSize: screenSize,
                    isDarkMood: isDarkMood,
                    controller: addModifierController.itemName,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Add Modifiers',
                        //style: kHeaderThreeTextStyle,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: TextFeildWidget(
                        screenSize: screenSize,
                        isDarkMood: isDarkMood,
                        controller: addModifierController.modifierName,
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
                  height: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Price',
                        //style: kHeaderThreeTextStyle,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: TextFeildWidget(
                        screenSize: screenSize,
                        isDarkMood: isDarkMood,
                        controller: addModifierController.itemPrice,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 200,
                      color: kMainColorLight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'ADD MODIFIER',
                          style: TextStyle(fontSize: 15, color: kWhiteLight),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kMainColorLight,
        child: const Icon(
          Icons.add,
          color: kWhiteLight,
        ),
      ),
    );
  }
}
