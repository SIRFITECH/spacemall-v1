import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;
    return Scaffold(
      backgroundColor:
          isDarkMood ? kDarkModeBackgroundColor : kLightModeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 340.0, left: 120),
        child: SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: (() {
                    // var tapIndex = index;
                    if (index == 0) {
                      Get.to(
                        () => DashBoard(),
                      );
                    }
                  }),
                  child: GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(
                            () => DashBoard(),
                          );
                          debugPrint('$index Own a store');
                          break;
                        case 1:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const AddCategory()),
                          // );
                          debugPrint('$index Customer');
                          break;
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: kBlackDark,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0),
                                ],
                                color: kWhiteLight,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SvgPicture.asset(
                                kMallIcon,
                                color: isDarkMood
                                    ? kDarkModeIconColor
                                    : kLightModeIconColor,
                                width: 80,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Text(
                            'Own A Store',
                            style: TextStyle(color: kWhiteLight),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
            )),
      ),
    );
  }
}
