import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/screens/add_staff.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../constants/image_strings.dart';
import '../../../../../../constants/text_strings.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffState();
}

class _StaffState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kStaffAppBarText,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMood
              ? kDarkModeBackgroundColor.withAlpha(2)
              : kWhiteLight.withAlpha(2),
          image: DecorationImage(
            image: isDarkMood
                ? const AssetImage(kBackGroundCartDarkMood)
                : const AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        padding: EdgeInsets.all(screenSize.width * 0.02),
        child: ListView(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.0, bottom: 8),
                  child: Text(
                    'Available StaffScreen',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
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
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                child: const ListTile(
                  title: Text('Timothy Timothy'),
                  subtitle: Text(
                    'timothytimothy@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(
                    Icons.radio_button_unchecked,
                    size: 25,
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
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                child: const ListTile(
                  title: Text('Timothy Timothy'),
                  subtitle: Text(
                    'timothytimothy@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(
                    Icons.radio_button_unchecked,
                    size: 25,
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
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                child: const ListTile(
                  title: Text('Timothy Timothy'),
                  subtitle: Text(
                    'timothytimothy@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(
                    Icons.radio_button_checked_sharp,
                    size: 25,
                    color: Colors.green,
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
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                child: const ListTile(
                  title: Text('Timothy Timothy'),
                  subtitle: Text(
                    'timothytimothy@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(
                    Icons.radio_button_unchecked,
                    size: 25,
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
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: kMainColorLight),
                ),
                child: const ListTile(
                  title: Text('Timothy Timothy'),
                  subtitle: Text(
                    'timothytimothy@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(
                    Icons.radio_button_checked_sharp,
                    size: 25,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AddStaff(),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AddStaff(),
          //   ),
          // );
        },
        backgroundColor: kMainColorLight,
        child: const Icon(
          Icons.person_add_alt_1,
          color: kWhiteLight,
        ),
      ),
    );
  }
}
