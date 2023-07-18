import 'package:flutter/material.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class DebtSummary extends StatefulWidget {
  const DebtSummary({super.key});

  @override
  State<DebtSummary> createState() => _DebtSummaryState();
}

class _DebtSummaryState extends State<DebtSummary> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kDebtSummaryAppBarText,
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'NAME ',
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: 35,
                child: TextFormField(
                  // validator: (name) {
                  //   if (name == null || name.isEmpty) {
                  //     return 'This is a required';
                  //   }
                  // },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kMainColorLight,
                        width: 2.0,
                      ),
                    ),
                    focusColor: kMainColorLight,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kMainColorLight, width: 2.0)),
                    hintText: 'OSAGIE DAVID',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  ),

                  onChanged: (nameValue) {
                    //name = nameValue;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('ITEMS'),
              ),
              Container(
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                padding: EdgeInsets.all(screenSize.height * 0.05),
                child: const Column(
                  children: [Text('   ')],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'AMOUNT',
                  //style: kHeaderThreeTextStyle,
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: 35,
                child: TextFormField(
                  // validator: (name) {
                  //   if (name == null || name.isEmpty) {
                  //     return 'This is a required';
                  //   }
                  // },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kMainColorLight,
                        width: 2.0,
                      ),
                    ),
                    focusColor: kMainColorLight,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kMainColorLight, width: 2.0)),
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  ),
                  onChanged: (nameValue) {
                    //name = nameValue;
                  },
                ),
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
              SizedBox(
                width: screenSize.width,
                height: 35,
                child: TextFormField(
                  // validator: (name) {
                  //   if (name == null || name.isEmpty) {
                  //     return 'This is a required';
                  //   }
                  // },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kMainColorLight,
                        width: 2.0,
                      ),
                    ),
                    focusColor: kMainColorLight,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kMainColorLight, width: 2.0)),
                    hintText: '29-01-2023',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  ),

                  //  enabled: false
                  onChanged: (nameValue) {
                    //name = nameValue;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02),
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
                            'SETTLED',
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
