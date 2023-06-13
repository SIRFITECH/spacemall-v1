import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final profileRepo = Get.put(ProfileRepo());
    // final profileController = Get.put(
    //   ProfileController(),
    // );

    // UserModel user = profileController.getUser
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel?>(
          future: profileRepo.getProfileDataFromPhone(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const CircularProgressIndicator();
            // } else if (snapshot.hasError) {
            //   return Text('Error: ${snapshot.error}');
            // } else
            if (!snapshot.hasData) {
              UserModel? user = snapshot.data;
              // print(user!.firstName);
              return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(kBackGroundCart),
                      fit: BoxFit.contain,
                    ),
                    //   color: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
                    //   borderRadius: const BorderRadius.only(
                    //     bottomLeft: Radius.circular(20),
                    //     bottomRight: Radius.circular(20),
                    //   ),
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
                            const Column(
                              children: [
                                Text(
                                  kCountryText,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlackDark,
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  // use the countryPicker emoji property to dispaly the user's country
                                  height: 40,
                                  // decoration: ,
                                  child: Text(
                                    'Country flag',
                                    // country.flagEmoji,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  //  Image.asset('images/flag.png'),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const SetProfile());
                                },
                                child: const Text('Edit Profile'))
                          ],
                        ),
                      ),
                      // // dp != null
                      // //     ?
                      // CircleAvatar(
                      //   radius: 50,
                      //   backgroundColor: kMainColorLight.withOpacity(0.4),
                      //   child: SizedBox(
                      //       child: ClipOval(
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 10.0),
                      //       child: SvgPicture.asset(
                      //         kProfileIcon,
                      //         // color: kMainColorLight.withOpacity(0.4),
                      //         width: 200,
                      //         height: 200,
                      //         fit: BoxFit.scaleDown,
                      //       ),
                      //     ),
                      //   )),
                      // ),
                      // // : CircleAvatar(
                      // //     radius: 30,
                      // //     backgroundColor: kMainColor.withOpacity(.01),
                      // //     backgroundImage: ap.userModel.profilePic == ''
                      // //         ? NetworkImage(
                      // //             _dp,
                      // //           )
                      // //         : NetworkImage(
                      // //             ap.userModel.profilePic,
                      // //           ),
                      // //   ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            kMainComplimemtColorDark.withOpacity(0.2),
                        child: SizedBox(
                            child: ClipOval(
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: // check if the image placeholder is empty, get image from
                                  // sharedPreferences, otherwise, display the icon
                                  // stockItem.itemPic ==
                                  //         null
                                  //     ?
                                  SvgPicture.asset(
                                kProfileIcon,
                                color: kMainColorDark,
                                width: 80,
                                height: 80,
                                fit: BoxFit.scaleDown,
                              )
                              // : CircleAvatar(
                              //     radius: 60,
                              //     backgroundImage:
                              //         FileImage(
                              //             stockItem
                              //                 .itemPic!),
                              //   ),
                              ),
                        )),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bio of the user',
                              // ap.userModel.bio,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBlackDark,
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
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kBlackDark,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'User\'s full name',
                                  // '${ap.userModel.firstName.toUpperCase()} ${ap.userModel.lastName.toUpperCase()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kMainColorLight,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlackDark,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    'User\'s email',
                                    // ap.userModel.email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kMainColorLight,
                                      fontSize: 20,
                                    ),
                                  ),
                                  // Text('john.doe@example.com'),
                                ),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  'Contact',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kBlackDark,
                                    fontSize: 17,
                                  ),
                                )),
                                DataCell(Row(
                                  children: [
                                    Text(
                                      'User\'s contact',
                                      // '+234 ${ap.userModel.contactNumber}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kMainColorLight,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                )),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  'Role',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kBlackDark,
                                    fontSize: 17,
                                  ),
                                )),
                                DataCell(
                                  Text(
                                    'User\'s rolee',
                                    // '${ap.userModel.firstName} ${ap.userModel.lastName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kMainColorLight,
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
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            // return Container(
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(kBackGroundCart),
            //         fit: BoxFit.contain,
            //       ),
            //       //   color: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
            //       //   borderRadius: const BorderRadius.only(
            //       //     bottomLeft: Radius.circular(20),
            //       //     bottomRight: Radius.circular(20),
            //       //   ),
            //     ),
            //     child: ListView(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 3.0, horizontal: 15),
            //           child: GestureDetector(
            //             onTap: () {},
            //             child: const Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Icon(Icons.arrow_back_ios),
            //                 Text(kBackText),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               const Column(
            //                 children: [
            //                   Text(
            //                     kCountryText,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: kBlackDark,
            //                         fontSize: 13),
            //                   ),
            //                   SizedBox(
            //                     // use the countryPicker emoji property to dispaly the user's country
            //                     height: 40,
            //                     // decoration: ,
            //                     child: Text(
            //                       'Country flag',
            //                       // country.flagEmoji,
            //                       style: TextStyle(
            //                           fontSize: 13,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     //  Image.asset('images/flag.png'),
            //                   ),
            //                 ],
            //               ),
            //               ElevatedButton(
            //                   onPressed: () {
            //                     Get.to(() => const SetProfile());
            //                   },
            //                   child: const Text('Edit Profile'))
            //             ],
            //           ),
            //         ),
            //         // // dp != null
            //         // //     ?
            //         // CircleAvatar(
            //         //   radius: 50,
            //         //   backgroundColor: kMainColorLight.withOpacity(0.4),
            //         //   child: SizedBox(
            //         //       child: ClipOval(
            //         //     child: Padding(
            //         //       padding: const EdgeInsets.only(top: 10.0),
            //         //       child: SvgPicture.asset(
            //         //         kProfileIcon,
            //         //         // color: kMainColorLight.withOpacity(0.4),
            //         //         width: 200,
            //         //         height: 200,
            //         //         fit: BoxFit.scaleDown,
            //         //       ),
            //         //     ),
            //         //   )),
            //         // ),
            //         // // : CircleAvatar(
            //         // //     radius: 30,
            //         // //     backgroundColor: kMainColor.withOpacity(.01),
            //         // //     backgroundImage: ap.userModel.profilePic == ''
            //         // //         ? NetworkImage(
            //         // //             _dp,
            //         // //           )
            //         // //         : NetworkImage(
            //         // //             ap.userModel.profilePic,
            //         // //           ),
            //         // //   ),
            //         CircleAvatar(
            //           radius: 40,
            //           backgroundColor:
            //               kMainComplimemtColorDark.withOpacity(0.2),
            //           child: SizedBox(
            //               child: ClipOval(
            //             child: Padding(
            //                 padding: const EdgeInsets.all(1.0),
            //                 child: // check if the image placeholder is empty, get image from
            //                     // sharedPreferences, otherwise, display the icon
            //                     // stockItem.itemPic ==
            //                     //         null
            //                     //     ?
            //                     SvgPicture.asset(
            //                   kProfileIcon,
            //                   color: kMainColorDark,
            //                   width: 80,
            //                   height: 80,
            //                   fit: BoxFit.scaleDown,
            //                 )
            //                 // : CircleAvatar(
            //                 //     radius: 60,
            //                 //     backgroundImage:
            //                 //         FileImage(
            //                 //             stockItem
            //                 //                 .itemPic!),
            //                 //   ),
            //                 ),
            //           )),
            //         ),

            //         const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Bio of the user',
            //                 // ap.userModel.bio,
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: kBlackDark,
            //                   fontSize: 17,
            //                 ),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.33,
            //           child: Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: DataTable(
            //               columns: const [
            //                 DataColumn(
            //                   label: Text(
            //                     'Name',
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: kBlackDark,
            //                       fontSize: 17,
            //                     ),
            //                   ),
            //                 ),
            //                 DataColumn(
            //                   label: Text(
            //                     'User\'s full name',
            //                     // '${ap.userModel.firstName.toUpperCase()} ${ap.userModel.lastName.toUpperCase()}',
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: kMainColorLight,
            //                       fontSize: 17,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //               rows: const [
            //                 DataRow(cells: [
            //                   DataCell(
            //                     Text(
            //                       'Email',
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: kBlackDark,
            //                         fontSize: 17,
            //                       ),
            //                     ),
            //                   ),
            //                   DataCell(
            //                     Text(
            //                       'User\'s email',
            //                       // ap.userModel.email,
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: kMainColorLight,
            //                         fontSize: 20,
            //                       ),
            //                     ),
            //                     // Text('john.doe@example.com'),
            //                   ),
            //                 ]),
            //                 DataRow(cells: [
            //                   DataCell(Text(
            //                     'Contact',
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: kBlackDark,
            //                       fontSize: 17,
            //                     ),
            //                   )),
            //                   DataCell(Row(
            //                     children: [
            //                       Text(
            //                         'User\'s contact',
            //                         // '+234 ${ap.userModel.contactNumber}',
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           color: kMainColorLight,
            //                           fontSize: 17,
            //                         ),
            //                       ),
            //                     ],
            //                   )),
            //                 ]),
            //                 DataRow(cells: [
            //                   DataCell(Text(
            //                     'Role',
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: kBlackDark,
            //                       fontSize: 17,
            //                     ),
            //                   )),
            //                   DataCell(
            //                     Text(
            //                       'User\'s rolee',
            //                       // '${ap.userModel.firstName} ${ap.userModel.lastName}',
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: kMainColorLight,
            //                         fontSize: 17,
            //                       ),
            //                     ),
            //                   ),
            //                 ]),
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     ));
          },
        ),
      ),
    );
  }
}
