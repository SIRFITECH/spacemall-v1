import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/nav_bar/screens/bottom_nav_bar_screen.dart';
import 'package:spacemall/src/features/core_app/drawer/screens/drawer_screen.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class MallScreen extends StatelessWidget {
  const MallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'spacemallio',
        automaticallyImplyLeading: true,
      ),
      drawer: const SpacemallDrawer(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: !isDarkMood
              ? const AssetImage(kBackGroundCart)
              : const AssetImage(kBackGroundCartDarkMood),
          fit: BoxFit.contain,
        )),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFeildWidget(
                            screenSize: screenSize,
                            isDarkMood: isDarkMood,
                            controller: controller,
                            keyboardType: TextInputType.text,
                            hintText: 'Which store are you buying from today',
                            labelText: '',
                            maxLines: 1,
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.8),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.live_help_outlined,
                                color: isDarkMood
                                    ? kDarkModeBrightIconColor
                                    : kDarkModeIconColor,
                                size: 30,
                              ),
                              const Text('Help')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MallBottomNavBar(),
    );
  }
}
