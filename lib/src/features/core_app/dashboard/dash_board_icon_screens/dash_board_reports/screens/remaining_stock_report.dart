import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';

class RemainingStock extends StatefulWidget {
  const RemainingStock({super.key});

  @override
  State<RemainingStock> createState() => _RemainingStockState();
}

class _RemainingStockState extends State<RemainingStock> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: kReportRemainingStockText,
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
        child: const Column(
          children: [
            SizedBox(
              height: 60,
              child: Card(
                // margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('N 2,000'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Card(
                // margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('N 2,000'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5alive(Medium)'),
                      Text('N 2,000'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    height: screenSize.height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.05,
                          decoration:
                              const BoxDecoration(color: kMainColorLight),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'SORT',
                                  style: TextStyle(color: kWhiteLight),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: kWhiteLight,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: screenSize.width * 0.1,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    topLeft: Radius.circular(35),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kWhiteLight,
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.red,
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 100.0)
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    // color: kWhiteLight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => const AddModifierSuccess(),
                                        //     ));
                                      },
                                      child: const Text(
                                        'Low to High',
                                        style: TextStyle(
                                            fontSize: 15, color: kBlackDark),
                                      ),
                                    ),
                                  ),
                                )),
                                Center(
                                    child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
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
                                        'High to Low',
                                        style: TextStyle(
                                            fontSize: 15, color: kWhiteLight),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        backgroundColor: kMainColorLight,
        child: const Icon(
          Icons.filter_alt_outlined,
          color: kWhiteLight,
        ),
      ),
    );
  }
}
