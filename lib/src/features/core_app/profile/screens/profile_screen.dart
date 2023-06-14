import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
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
    final screenSize = media.size;

    final profileRepo = Get.put(ProfileRepo());

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel?>(
          future: profileRepo.getUserDataFromPhone(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              UserModel? user = snapshot.data;
              print(user!.firstName);
              return Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(kBackGroundCart),
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
                          onTap: () {},
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
                                    user.country,
                                    style: TextStyle(
                                      fontSize: 13,
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
                              backgroundImage: NetworkImage(user.profilePic),
                            ),
                          ),
                        )),
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
                                  kNameText,
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
                                  '${user.firstName} ${user.lastName}',
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
                                  kContactText,
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
