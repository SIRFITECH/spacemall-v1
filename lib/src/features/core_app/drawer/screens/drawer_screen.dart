import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/profile/screens/profile_screen.dart';
import 'package:spacemall/src/features/core_app/store/screens/add_store.dart';
import 'package:spacemall/src/utils/themes/app_theme_mood.dart';
import 'package:spacemall/src/utils/themes/custom_text_styles.dart';

import '../../../../repository/services/phone_storage/user_phone_services.dart';
import '../../../../utils/themes/themes.dart';
import '../../dashboard/dash_board_display/screens/dash_board_screen.dart';
import '../../settings/screens/settings_screen.dart';

class SpacemallDrawer extends StatelessWidget {
  const SpacemallDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final profileController = Get.put(ProfileController());
    final themeController = Get.put(ThemeController());

    return FutureBuilder<UserModel?>(
        future: profileController.getUserDataFromHive(),
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
                          fontSize: kHeaderTextFont,
                        ),
                      ),
                      accountEmail: Text(
                        user.email,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: kBodyTextFont,
                              color: kWhiteLight,
                            ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          child: ClipOval(
                            child: FutureBuilder<void>(
                              future: precacheImage(
                                  UserPhoneServices().chooseImageProvider(
                                    profileController.isConnected,
                                    user.profilePicLocalPath,
                                    user.profilePicRemotePath,
                                  ),
                                  context),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        UserPhoneServices().chooseImageProvider(
                                      profileController.isConnected,
                                      user.profilePicLocalPath,
                                      user.profilePicRemotePath,
                                    ),
                                  );
                                } else {
                                  return const CircularProgressIndicator(
                                    backgroundColor: kWhiteLight,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          horizontalTitleGap: kHorizontalTitleGap,
                          onTap: () {
                            Get.off(() => DashBoard());
                          },
                          leading: const Icon(
                            Icons.home_sharp,
                            color: kWhiteLight,
                            size: kHeaderTextFont,
                          ),
                          title: const Text(
                            kDashBoardIconText,
                            style: kDrawerTextStyle,
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: kHorizontalTitleGap,
                          onTap: () {
                            Get.to(
                              () => const ProfileScreen(),
                            );
                          },
                          leading: const Icon(
                            Icons.person,
                            color: kWhiteLight,
                            size: kHeaderTextFont,
                          ),
                          title: const Text(
                            kProfileIconText,
                            style: kDrawerTextStyle,
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: kHorizontalTitleGap,
                          onTap: () {
                            Get.off(() => const SettingsScreen());
                          },
                          leading: const Icon(
                            Icons.settings,
                            color: kWhiteLight,
                            size: kHeaderTextFont,
                          ),
                          title: const Text(
                            kSettingIconText,
                            style: kDrawerTextStyle,
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: kHorizontalTitleGap,
                          onTap: () {
                            Get.to(() => const AddStore());
                          },
                          leading: const Icon(
                            Icons.storefront_rounded,
                            color: kWhiteLight,
                            size: kHeaderTextFont,
                          ),
                          title: const Text(
                            kAddNewStoreText,
                            style: kDrawerTextStyle,
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: kHorizontalTitleGap,
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
                          horizontalTitleGap: kHorizontalTitleGap,
                          onTap: () async {
                            await AuthRepo.instance.signOut();
                          },
                          leading: const Icon(
                            Icons.logout_sharp,
                            color: kWhiteLight,
                            size: kHeaderTextFont,
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
