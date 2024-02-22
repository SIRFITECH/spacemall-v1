import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

import '../../../../repository/services/phone_storage/user_phone_services.dart';
import '../application/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    final profileController = ProfileController();

    final LoginController loginController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: 'Profile',
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<UserModel?>(
          future: profileController.getUserDataFromHive(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              UserModel? user = snapshot.data;

              return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: !isDarkMood
                          ? const AssetImage(kBackGroundCart)
                          : const AssetImage(kBackGroundCartDarkMood),
                      fit: BoxFit.contain,
                    ),
                    color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  kCountryText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDarkMood ? kWhiteLight : kBlackDark,
                                    fontSize: kBodyTextFont,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Text(
                                    loginController.country.value.flagEmoji,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDarkMood ? kWhiteLight : kBlackDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => const SetProfile());
                              },
                              child: const Text(
                                kEditProfileText,
                                style: TextStyle(
                                  fontSize: kBodyTextFont,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          child: ClipOval(
                            child: FutureBuilder<void>(
                              future: precacheImage(
                                UserPhoneServices().chooseImageProvider(
                                  profileController.isConnected,
                                  user!.profilePicLocalPath,
                                  user.profilePicRemotePath,
                                ),
                                context,
                              ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.bio,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMood ? kWhiteLight : kBlackDark,
                                fontSize: kHeaderTextFontSmall,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text(
                                  kUserNameText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDarkMood ? kWhiteLight : kBlackDark,
                                    fontSize: kHeaderTextFontSmallest,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  user.userName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMood
                                        ? kDarkModeIconColor
                                        : kLightModeIconColor,
                                    fontSize: kBodyTextFont,
                                  ),
                                ),
                              ),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(
                                  Text(
                                    kEmailText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDarkMood ? kWhiteLight : kBlackDark,
                                      fontSize: kHeaderTextFontSmallest,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    user.email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMood
                                          ? kDarkModeIconColor
                                          : kLightModeIconColor,
                                      fontSize: kBodyTextFont,
                                    ),
                                  ),
                                ),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  kPhoneText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDarkMood ? kWhiteLight : kBlackDark,
                                    fontSize: kHeaderTextFontSmallest,
                                  ),
                                )),
                                DataCell(Row(
                                  children: [
                                    Text(
                                      user.contactNumber,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMood
                                            ? kDarkModeIconColor
                                            : kLightModeIconColor,
                                        fontSize: kBodyTextFont,
                                      ),
                                    ),
                                  ],
                                )),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  kRoleText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDarkMood ? kWhiteLight : kBlackDark,
                                    fontSize: kHeaderTextFontSmallest,
                                  ),
                                )),
                                DataCell(
                                  Text(
                                    user.role,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMood
                                          ? kDarkModeIconColor
                                          : kLightModeIconColor,
                                      fontSize: kBodyTextFont,
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            }
          },
        ),
      ),
    );
  }
}
