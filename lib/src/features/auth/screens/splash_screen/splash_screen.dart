import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/auth/application/splash_controller/splash_controller.dart';
import 'package:spacemall/src/features/auth/screens/auth_check/auth_check.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;
    final SplashController splashController = Get.find();
    return Scaffold(
      backgroundColor:
          isDarkMood ? kDarkModeBackgroundColor : kLightModeBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            top: screenSize.height * 0.4, left: screenSize.width * 0.28),
        child: SizedBox(
            height: screenSize.height * 0.2,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: (() {
                    if (index == 0) {
                      Get.offAll(
                        () => const AuthCheckScreen(),
                      );
                    }
                  }),
                  child: GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.offAll(
                            () => const AuthCheckScreen(),
                          );
                          splashController.userRole.value = 'Store Owner';

                          break;
                        case 1:
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                'Oops!!',
                                style: TextStyle(
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                  fontSize: kHeaderTextFontSmallest,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              content: Text(
                                'Sorry, We are only testing the store feature for now',
                                style: TextStyle(
                                  color: isDarkMood ? kWhiteLight : kBlackDark,
                                  fontSize: kBodyTextFont,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Back'),
                                ),
                              ],
                            ),
                          );
                          // Get.offAll(
                          //   () => const MallScreen(),
                          // );
                          splashController.userRole.value = 'Buyer';

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
                                splashController.icons[index],
                                // ignore: deprecated_member_use
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
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            splashController.role[index],
                            style: const TextStyle(
                                color: kWhiteLight, fontSize: 12),
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
