import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/settings/screens/printer_setting.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

// class Settings extends StatelessWidget {
//   const Settings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final userContr = UserController();
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Settings',
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const Column(
//               children: [],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     print(AuthRepo.instance.uid);
//                   },
//                   child: const Text('Print User Data'),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     AuthRepo.instance
//                         .setSignedOut()
//                         .then((value) => AuthRepo.instance.signOut());
//                     Get.to(() => const Login());
//                   },
//                   child: const Text('Clear Data'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
              color: isDarkMood
                  ? kDarkModeBackgroundColor.withAlpha(2)
                  : kWhiteLight.withAlpha(2),
              image: const DecorationImage(
                image: AssetImage(kBackGroundCart),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Icon(Icons.arrow_back_ios), Text("Back")],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tax Setttings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kBlackDark),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 8.0,
                              color: kMainColorLight,
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: '12%',
                      //   ),
                      // ),
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
                            fontWeight: FontWeight.bold, color: kBlackDark),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            // top: BorderSide(
                            //     width: 16.0, color: Colors.lightBlue.shade600),
                            bottom:
                                BorderSide(width: 8.0, color: kMainColorLight),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: '12%',
                      //   ),
                      // ),
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
                          color: kBlackDark,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
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
                          color: kBlackDark,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            // top: BorderSide(
                            //     width: 16.0, color: Colors.lightBlue.shade600),
                            bottom:
                                BorderSide(width: 8.0, color: kMainColorLight),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: '12%',
                      //   ),
                      // ),
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
                          color: kBlackDark,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            // top: BorderSide(
                            //     width: 16.0, color: Colors.lightBlue.shade600),
                            bottom:
                                BorderSide(width: 8.0, color: kMainColorLight),
                          ),
                          // color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('12%'),
                        ),
                      )
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     border: UnderlineInputBorder(),
                      //     labelText: '12%',
                      //   ),
                      // ),
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
                          color: kBlackDark,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            // top: BorderSide(
                            //     width: 16.0, color: Colors.lightBlue.shade600),
                            bottom:
                                BorderSide(width: 8.0, color: kMainColorLight),
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
                          color: kBlackDark,
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
                            color: kBlackDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.02),
                        child: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            height: 40,
                            width: 130,
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
                                'SAVE',
                                style:
                                    TextStyle(fontSize: 13, color: kWhiteLight),
                              ),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
