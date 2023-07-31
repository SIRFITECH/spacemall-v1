import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});
  static String id = 'add_staff_screen';

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kAddStaffAppBarText,
        automaticallyImplyLeading: false,
      ),
      // AppBar(
      //   title: const Text("ADD STAFF"),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         print('Add Staff');
      //       },
      //       // =>
      //       // saveStaff(),
      //       child: const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 32.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.only(top: 8.0),
      //               child: Text('Save', style: TextStyle(fontSize: 16)),
      //             ),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Icon(
      //               Icons.save_alt,
      //               color: kWhiteLight,
      //               size: 25,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

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
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // first Name container
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFeildWidget(
                        labelText: kAddStaffFirstNameText,
                        hintText: 'First Name',
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: firstNameController,
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.45,
                        isDarkMood: isDarkMood,
                        screenSize: screenSize,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFeildWidget(
                        hintText: kAddStaffLastNameText,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: lastNameController,
                        width: screenSize.width * 0.45,
                        height: screenSize.height * 0.05,
                        isDarkMood: isDarkMood,
                        labelText: kAddStaffLastNameText,
                        screenSize: screenSize,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              // email container

              TextFeildWidget(
                hintText: kAddStaffEmailHintText,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                controller: emailController,
                height: screenSize.height * 0.05,
                width: screenSize.width * 0.9,
                isDarkMood: isDarkMood,
                labelText: kAddStaffEmailText,
                screenSize: screenSize,
              ),

              const SizedBox(
                height: 10,
              ),
              const Text('PERMISSSIONS AND DUTIES',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor)),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ADMIN'),
                      Text('HELPER'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MANAGER'),
                      Text('CUSTOM'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('RECEIPT MANAGEMENT',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor)),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('CREATE RECEIPT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('CREATE RECEIPT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('RETURN RECEIPT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('ADMIN'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('SALES COUNTER PERMISSSIONS',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor)),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('DISCOUNTT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('FREE'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('ADD CHARGES'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('ADD TAX'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('GET CREDIT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('ITEM MANAGEMENT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: kGreyColor,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('VIEW ONLY'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('CREATE '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('EDIT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('ADMIN'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('STOREFRONT PERMISSSIONS',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor)),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('MANAGE BANNER '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('SF SETTINGS '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('CREATE '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('MANAGE SF ORDERS '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('CUSTOMER MANAGEMENT',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor)),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('CREATE '),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('VIEW ONLY'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('EDIT'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('ADMIN'),
                          Icon(
                            Icons.radio_button_checked,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColorLight,
        onPressed: () {},
        // =>
        // saveStaff(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Save',
                  style: TextStyle(
                    fontSize: 14,
                    color: kWhiteLight,
                  )),
              Icon(
                Icons.save_alt,
                color: kWhiteLight,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  // // save staff to
  // saveStaff() async {
  //   // make an instance of Staff provider
  //   final sp = Provider.of<AddStaffProvider>(context, listen: false);
  //   StaffModel staffModel = StaffModel(
  //     staffFirstName: firstNameController.text.trim(),
  //     staffLastName: lastNameController.text.trim(),
  //     staffEmail: emailController.text.trim(),
  //     uid: '',
  //   );
  //   if (firstNameController.value != null || lastNameController.value != null) {
  //     sp.saveStaffDataToDb(
  //       context: context,
  //       staffModel: staffModel,
  //       onSuccess: () {},
  //     );
  //     sp.saveStaffDataToDb(
  //       context: context,
  //       staffModel: staffModel,
  //       onSuccess: () {
  //         sp.saveStaffDataToSharedPreference().then(
  //               (value) => Navigator.pushAndRemoveUntil(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const Staff(),
  //                   ),
  //                   (route) => false),
  //               // sp.setSignedIn().then(
  //               //       (value) => Navigator.pushAndRemoveUntil(
  //               //           context,
  //               //           MaterialPageRoute(
  //               //             builder: (context) => const Staff(),
  //               //           ),
  //               //           (route) => false),
  //               //     ),
  //             );
  //         showSnackBar(context, 'Staff added successfully');
  //       },
  //     );
  //   } else {
  //     showSnackBar(context, "Please add a profile picture");
  //   }
  // }
}
