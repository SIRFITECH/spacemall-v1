import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class ShopFrontSettings extends StatefulWidget {
  const ShopFrontSettings({super.key});

  @override
  State<ShopFrontSettings> createState() => _ShopFrontSettingsState();
}

class _ShopFrontSettingsState extends State<ShopFrontSettings> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kShopFrontSettingsAppBarText,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMood
                ? kDarkModeBackgroundColor.withAlpha(2)
                : kWhiteLight.withAlpha(2),
            image: const DecorationImage(
              image: AssetImage(kBackGroundCart),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: screenSize.height * 0.7,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: kMainColorLight),
                          ),
                          child: const ListTile(
                            title: Text('Show home screen'),
                            subtitle: Text(
                              'banners, category, group items',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            trailing: Icon(
                              Icons.toggle_off_outlined,
                              size: 50,
                              color: kMainColorLight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: kMainColorLight),
                          ),
                          child: const ListTile(
                            title: Text('Show cover screen'),
                            subtitle: Text(
                              'Group all varients or sub items as single item with options',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            trailing: Icon(
                              Icons.toggle_on,
                              size: 50,
                              color: kMainColorLight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const TopCustomerReportDetails(),
                          //     ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: kMainColorLight),
                          ),
                          child: const ListTile(
                            title: Text('Enable item grouping'),
                            subtitle: Text(
                              'Group all varients or sub items as single item with options',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            trailing: Icon(
                              Icons.toggle_off_outlined,
                              size: 50,
                              color: kMainColorLight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                          width: screenSize.height * 0.15,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => const ShopFrontSettings(),
                                );
                              },
                              child: const Text(kSaveText)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
