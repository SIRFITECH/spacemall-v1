import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/settings/screens/printer_setting.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SetPrinterState();
}

class _SetPrinterState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
              image: DecorationImage(
                image: !isDarkMood
                    ? const AssetImage(kBackGroundCart)
                    : const AssetImage(kBackGroundCartDarkMood),
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Icon(Icons.arrow_back_ios), Text("Back")],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tax Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: !isDarkMood
                                  ? kTextFieldLightBorderColor.withOpacity(0.5)
                                  : kTextFieldDarkBorderColor.withOpacity(0.5),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Discount Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: !isDarkMood
                                  ? kTextFieldLightBorderColor.withOpacity(0.5)
                                  : kTextFieldDarkBorderColor.withOpacity(0.5),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Mode Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery Fee Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: !isDarkMood
                                  ? kTextFieldLightBorderColor.withOpacity(0.5)
                                  : kTextFieldDarkBorderColor.withOpacity(0.5),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Service Fees Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: !isDarkMood
                                  ? kTextFieldLightBorderColor.withOpacity(0.5)
                                  : kTextFieldDarkBorderColor.withOpacity(0.5),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Other Fees Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: !isDarkMood
                                  ? kTextFieldLightBorderColor.withOpacity(0.5)
                                  : kTextFieldDarkBorderColor.withOpacity(0.5),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.receipt_long_sharp,
                        size: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Receipt Setttings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const PrinterSettings(),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.print_rounded,
                          size: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Printer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: screenSize.height * 0.02),
                  //       child: Center(
                  //           child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(6),
                  //         child: Container(
                  //           height: 40,
                  //           width: 130,
                  //           color: kMainColorLight,
                  //           child: TextButton(
                  //             onPressed: () {
                  //               // Navigator.push(
                  //               //     context,
                  //               //     MaterialPageRoute(
                  //               //       builder: (context) => const AddModifierSuccess(),
                  //               //     ));
                  //             },
                  //             child: const Text(
                  //               'SAVE',
                  //               style:
                  //                   TextStyle(fontSize: 13, color: kWhiteLight),
                  //             ),
                  //           ),
                  //         ),
                  //       )),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
