import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';

import '../../../../constants/image_strings.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenSize = media.size;
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
      body: Container(
        padding: const EdgeInsets.all(kDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              height: screenSize.height * 0.5,
              image: const AssetImage(kWelcomeIllustration),
            ),
            Text(
              kWelcomeScreenText,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => const Login(),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const Login(),
                      //   ),
                      // );
                    },
                    child: const Text(kShopNow),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
