import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';

class SplascreenLoader extends StatelessWidget {
  const SplascreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    return Scaffold(
      backgroundColor: kWhiteLight,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !isDarkMood
                ? const AssetImage(kBackGroundAfrica)
                : const AssetImage(kBackGroundAfrica),
            fit: BoxFit.contain,
          ),
          color: isDarkMood ? kDarkModeBackgroundColor : kWhiteLight,
        ),
        child: const Center(
          child:
              //     Container(
              //   height: screenSize.height * 0.05,
              //   width: screenSize.width * 0.1,
              //   child: const Padding(
              //     padding: EdgeInsets.all(1.0),
              //     child: CircularProgressIndicator(),
              //   ),
              // )
              Text(
            'Loading...',
            style: TextStyle(color: kBlack),
          ),

          // Column(
          //   children: [
          //     // isDarkMood
          //     //     ?
          //     // Image.asset(
          //     //   kSpacemallLogoColored,
          //     //   height: screenSize.height * 0.5,
          //     // ),
          //     // : Image.asset(
          //     //     kBackGroundCartDarkMood,
          //     //     height: screenSize.height * 0.5,
          //     //   ),
          //     Text(
          //       'Loading...',
          //       style: TextStyle(color: kBlack),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
