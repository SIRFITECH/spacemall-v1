import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/profile/screens/profile_screen.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';
import 'package:spacemall/src/utils/themes/app_theme_mood.dart';
import 'package:spacemall/src/utils/themes/custom_text_styles.dart';

import '../../../../utils/themes/themes.dart';
import '../../settings/screens/settings_screen.dart';

class SpacemallDrawer extends StatelessWidget {
  const SpacemallDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final profileRepo = Get.put(ProfileRepo());
    final themeController = Get.put(ThemeController());

    return FutureBuilder<UserModel?>(
        future: profileRepo.getUserDataFromPhone(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            UserModel? user = snapshot.data;
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
                      accountName: Text(
                        user!.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      accountEmail: Text(user.email),
                      currentAccountPicture: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          child: ClipOval(
                            child: FutureBuilder<void>(
                              future: precacheImage(
                                NetworkImage(user.profilePic),
                                context,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return CircleAvatar(
                                    backgroundColor: kWhiteDark,
                                    radius: 100,
                                    backgroundImage:
                                        NetworkImage(user.profilePic),
                                  );
                                } else {
                                  return const CircularProgressIndicator(
                                    backgroundColor: kWhiteLight,
                                  );
                                }
                              },
                            ),

                            //  CircleAvatar(
                            //   radius: 100,
                            //   backgroundImage: NetworkImage(user.profilePic),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          onTap: () {
                            // Get.off(() => DashBoard());
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
                            Get.to(
                              () => const ProfileScreen(),
                            );
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
                            Get.off(() => const SettingsScreen());
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
                            Get.to(() => const AddStore());
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
                          onTap: () {},
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
                            if (Get.isDarkMode) {
                              themeController.changeTheme(SAppTheme.lightTheme);
                              themeController.saveTheme(false);
                            } else {
                              themeController.changeTheme(SAppTheme.darkTheme);
                              themeController.saveTheme(true);
                            }
                            profileRepo.toggleThemeMode();
                            // showModalBottomSheet(
                            //   context: context,
                            //   builder: (context) {
                            //     return Container(
                            //       width: double.infinity,
                            //       height: screenSize.height * 0.3,
                            //       padding: EdgeInsets.all(
                            //         screenSize.height * 0.025,
                            //       ),
                            //       child: Column(
                            //         children: [
                            //           const Text(
                            //             kDarkMoodText,
                            //             style: TextStyle(
                            //               color: kBlackDark,
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.normal,
                            //             ),
                            //           ),
                            //           const SizedBox(
                            //             height: 10,
                            //           ),
                            //           Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               const Padding(
                            //                 padding:
                            //                     EdgeInsets.only(left: 10.0),
                            //                 child: Text(kDarkMoodText),
                            //               ),
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.start,
                            //                 children: [
                            //                   Column(
                            //                     children: [
                            //                       CustomRadio(
                            //                           onChange: (value) {},
                            //                           color:
                            //                               kLightModeIconColor,
                            //                           value: true,
                            //                           groupValue: true),
                            //                       const Text(kOnText)
                            //                     ],
                            //                   ),
                            //                   Column(
                            //                     children: [
                            //                       CustomRadio(
                            //                           onChange: (value) {},
                            //                           color:
                            //                               kLightModeIconColor,
                            //                           value: true,
                            //                           groupValue: true),
                            //                       const Text(kOffText)
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(
                            //                     left: 10.0),
                            //                 child: Row(
                            //                   children: [
                            //                     const Text(
                            //                       kUseSystemSettingsText,
                            //                       // style: TextStyle(color: kBlack),
                            //                     ),
                            //                     CustomRadio(
                            //                         onChange: (value) {},
                            //                         color: kLightModeIconColor,
                            //                         value: false,
                            //                         groupValue: false)
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // );
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
        });
  }
}
