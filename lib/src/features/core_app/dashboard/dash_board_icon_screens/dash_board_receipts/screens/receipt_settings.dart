import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class ReceiptSettings extends StatefulWidget {
  const ReceiptSettings({super.key});
  static String id = 'receipt_settings_screen';

  @override
  State<ReceiptSettings> createState() => _ReceiptSettingsState();
}

class _ReceiptSettingsState extends State<ReceiptSettings> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: kReceiptsSettingsAppBarText,
          automaticallyImplyLeading: false),
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
        child: ListView(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Business Name',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 40,
                //   child: TextFormField(
                //     // validator: (name) {
                //     //   if (name == null || name.isEmpty) {
                //     //     return 'This is a required';
                //     //   }
                //     // },
                //     decoration: kInputTextFieldStyle.copyWith(
                //       hintText: 'Sirfitech',
                //       hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     onChanged: (nameValue) {
                //       //name = nameValue;
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Business Phone Number',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Business Address',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 35,
                //   child: TextFormField(
                //     // validator: (name) {
                //     //   if (name == null || name.isEmpty) {
                //     //     return 'This is a required';
                //     //   }
                //     // },
                //     decoration: kInputTextFieldStyle.copyWith(
                //       hintText: '6, Paragon estate, Kaura Abuja',
                //       hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     onChanged: (nameValue) {
                //       //name = nameValue;
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Tax no. and Title',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 35,
                //   child: TextFormField(
                //     // validator: (name) {
                //     //   if (name == null || name.isEmpty) {
                //     //     return 'This is a required';
                //     //   }
                //     // },
                //     decoration: kInputTextFieldStyle.copyWith(
                //       hintText: 'SFTIN:WDSD123H23H',
                //       hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     onChanged: (nameValue) {
                //       //name = nameValue;
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Website Address',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Reciept Title',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 35,
                //   child: TextFormField(
                //     // validator: (name) {
                //     //   if (name == null || name.isEmpty) {
                //     //     return 'This is a required';
                //     //   }
                //     // },
                //     decoration: kInputTextFieldStyle.copyWith(
                //       hintText: 'Invoice',
                //       hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     onChanged: (nameValue) {
                //       //name = nameValue;
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Receipt Logo',
                    //style: kHeaderThreeTextStyle,
                  ),
                ),
                Container(
                  width: screenSize.width * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: kMainColorLight,
                    ),
                  ),
                  padding: EdgeInsets.all(screenSize.height * 0.05),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add_home_outlined,
                        size: 30,
                      ),
                      Text('ADD NEW ITEM')
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenSize.height * 0.05),
                      child: Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          width: 100,
                          color: kMainComplimemtColorDark,
                          child: TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const AddModifierSuccess(),
                              //     ));
                            },
                            child: const Text(
                              'Remove',
                              style:
                                  TextStyle(fontSize: 15, color: kWhiteLight),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
