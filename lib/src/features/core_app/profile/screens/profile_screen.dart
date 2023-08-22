import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
// import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    final profileRepo = Get.put(ProfileRepo());
    final LoginController loginController = Get.find();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel?>(
          future: profileRepo.getUserDataFromPhone(),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios),
                              Text(kBackText),
                            ],
                          ),
                        ),
                      ),
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
                                      fontSize: 13),
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
                              child: const Text(kEditProfileText),
                            )
                          ],
                        ),
                      ),

                      // CircleAvatar(
                      //   radius: 60,
                      //   backgroundColor:
                      //       kMainComplimemtColorDark.withOpacity(0.2),
                      //   child: SizedBox(
                      //     child: ClipOval(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(2.0),
                      //         child: FutureBuilder<void>(
                      //           future: ProfileController.instance
                      //               .loadProfilePicture(),
                      //           builder: (context, snapshot) {
                      //             if (snapshot.connectionState ==
                      //                 ConnectionState.waiting) {
                      //               return CircularProgressIndicator(); // Show loading indicator
                      //             } else if (snapshot.hasError) {
                      //               return Center(
                      //                 child: Text(
                      //                     'Error loading profile picture'), // Show error message
                      //               );
                      //             } else {
                      //               return CircleAvatar(
                      //                 radius: 60,
                      //                 backgroundImage:
                      //                     NetworkImage(user!.profilePic),
                      //               );
                      //             }
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            kMainComplimemtColorDark.withOpacity(0.2),
                        child: SizedBox(
                            child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(user!.profilePic),
                            ),
                          ),
                        )),
                      ),

                      // // I want to display the image as a file
                      // SizedBox(
                      //   child: ClipOval(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(1.0),
                      //       child: CircleAvatar(
                      //         radius: 30,
                      //         backgroundImage: FileImage(
                      //           File(user.profilePic),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                                fontSize: 17,
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
                                    fontSize: 17,
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
                                    fontSize: 17,
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
                                      fontSize: 17,
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
                                      fontSize: 20,
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
                                    fontSize: 17,
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
                                        fontSize: 17,
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
                                    fontSize: 17,
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
                                      fontSize: 17,
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
