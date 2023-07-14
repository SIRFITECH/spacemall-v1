import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';

class AddToDebt extends StatefulWidget {
  const AddToDebt({super.key});
  static String id = 'add_to_debt_screen';

  @override
  State<AddToDebt> createState() => _AddToDebtState();
}

class _AddToDebtState extends State<AddToDebt> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add To Debt'),
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
                labelText: 'Name',
                maxLines: 1,
                height: screenSize.height * 0.05,
                width: screenSize.width * 0.4,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'NAME ',
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
              //       hintText: '',
              //       hintStyle: const TextStyle(fontSize: 12),
              //     ),
              //     onChanged: (nameValue) {
              //       //name = nameValue;
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'PHONE ',
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
              //       hintText: '',
              //       hintStyle: const TextStyle(fontSize: 12),
              //     ),
              //     onChanged: (nameValue) {
              //       //name = nameValue;
              //     },
              //   ),
              // ),

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
                  border: Border.all(width: 1, color: kMainColorLight
                      // MediaQuery.of(context).size.height * 0.05,
                      ),
                ),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  children: const [Text('   ')],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'AMOUNT',
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
              //       hintText: '',
              //       hintStyle: const TextStyle(fontSize: 12),
              //     ),
              //     onChanged: (nameValue) {
              //       //name = nameValue;
              //     },
              //   ),
              // ),
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
              //       hintText: '',
              //       hintStyle: const TextStyle(fontSize: 12),
              //     ),
              //     //  enabled: false
              //     onChanged: (nameValue) {
              //       //name = nameValue;
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: 150,
                        color: kMainColorLight,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const AddModifierSuccess(),
                            //     ));
                          },
                          child: const Text(
                            'ADD',
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
      ),
    );
  }
}
