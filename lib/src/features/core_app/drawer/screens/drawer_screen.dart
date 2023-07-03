import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/general/custom_radio.dart';
import 'package:spacemall/src/utils/themes/custom_text_styles.dart';

class SpacemallDrawer extends StatelessWidget {
  const SpacemallDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    return Drawer(
      backgroundColor: isDarkMood
          ? kDarkModeIconColor.withOpacity(0.7)
          : kLightModeBackgroundColor.withOpacity(0.7),
      child: ListView(children: [
        Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMood
                    ? kDarkModeIconColor.withOpacity(0.7)
                    : kLightModeBackgroundColor.withOpacity(0.7),
              ),
              accountName: const Text('Name Of Owner'),

              accountEmail: const Text("emailofowner@gmail.com"),
              // Text(ap.userModel.email),
              currentAccountPicture: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                child: SizedBox(
                    child: ClipOval(
                  child:
                      //  CircleAvatar(
                      //   radius: 100,
                      //   backgroundColor: kMainColor.withOpacity(.01),
                      //   backgroundImage: NetworkImage(
                      //     ap.userModel.profilePic,
                      //   ),
                      // ),

                      Image.asset(
                    kTrialImage1,
                    width: 100,
                    height: 100,
                  ),
                )),
              ),
              // otherAccountsPictures: [
              //   CircleAvatar(
              //     radius: 100,
              //     backgroundColor: Colors.transparent,
              //     child: SizedBox(
              //         child: ClipOval(
              //       child: Image.asset(kTrailImage2),
              //     )),
              //   ),
              //   CircleAvatar(
              //     radius: 100,
              //     backgroundColor: Colors.transparent,
              //     child: SizedBox(
              //         child: ClipOval(
              //       child: Image.asset(kTrailImage3),
              //     )),
              //   ),
              //   CircleAvatar(
              //     radius: 100,
              //     backgroundColor: Colors.transparent,
              //     child: SizedBox(
              //         child: ClipOval(
              //       child: Image.asset(kTrialImage1),
              //     )),
              //   ),
              //   CircleAvatar(
              //     radius: 100,
              //     backgroundColor: Colors.transparent,
              //     child: SizedBox(
              //         child: ClipOval(
              //       child: Image.asset(kTrailImage2),
              //     )),
              //   ),
              // ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    Get.to(() => DashBoard());
                  },
                  leading: const Icon(
                    Icons.home_sharp,
                    color: kWhiteLight,
                    size: 27,
                  ),
                  title: const Text(
                    kDashBoardIconText,
                    style: kDrawerTextStyle,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    Get.to(() => DashBoard());
                  },
                  leading: const Icon(
                    Icons.person,
                    color: kWhiteLight,
                  ),
                  title: const Text(
                    kProfileIconText,
                    style: kDrawerTextStyle,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    // Navigator.pushNamed(context, SettingsHome.id);
                  },
                  leading: const Icon(
                    Icons.settings,
                    color: kWhiteLight,
                  ),
                  title: const Text(
                    kSettingIconText,
                    style: kDrawerTextStyle,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    // Navigator.pushNamed(context, );
                  },
                  leading: const Icon(
                    Icons.storefront_rounded,
                    color: kWhiteLight,
                  ),
                  title: const Text(
                    kAddNewStoreText,
                    style: kDrawerTextStyle,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    // Navigator.pushNamed(context, Help.id);
                  },
                  leading: const Icon(
                    Icons.contact_support_rounded,
                    color: kWhiteLight,
                  ),
                  title: const Text(
                    kHelpText,
                    style: kDrawerTextStyle,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  onTap: () {
                    // ap.signOut();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SignIn(),
                    //   ),
                    // );
                    // // print('Signed out');
                  },
                  leading: const Icon(
                    Icons.logout_sharp,
                    color: kWhiteLight,
                  ),
                  title: const Text(
                    kSignOutText,
                    style: kDrawerTextStyle,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.25),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: screenSize.height * 0.3,
                          padding: EdgeInsets.all(
                            screenSize.height * 0.025,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                kDarkMoodText,
                                style: TextStyle(
                                  color: kBlackDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(kDarkMoodText),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          CustomRadio(
                                              onChange: (value) {},
                                              color: kLightModeIconColor,
                                              value: true,
                                              groupValue: true),
                                          const Text(kOnText)
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CustomRadio(
                                              onChange: (value) {},
                                              color: kLightModeIconColor,
                                              value: true,
                                              groupValue: true),
                                          const Text(kOffText)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          kUseSystemSettingsText,
                                          // style: TextStyle(color: kBlack),
                                        ),
                                        CustomRadio(
                                            onChange: (value) {},
                                            color: kLightModeIconColor,
                                            value: false,
                                            groupValue: false)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      isDarkMood
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      color: kWhiteLight,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
