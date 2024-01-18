import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({
    super.key,
    required this.isDarkMood,
    required this.title,
    required this.automaticallyImplyLeading,
    // this.showBackButton,
    this.action,
  });
  // : super(key: key);

  final bool isDarkMood;
  final String title;
  final bool automaticallyImplyLeading;
  // late bool? showBackButton;
  late VoidCallback? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // showBackButton = !automaticallyImplyLeading;

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      title: Text(title.toUpperCase()),
      titleTextStyle: TextStyle(
        color: isDarkMood ? kWhiteLight : kMainComplimemtColorLight,
        fontSize: kLiquidSwipeHeader,
        fontWeight: FontWeight.w900,
      ),
      backgroundColor: isDarkMood
          ? kDarkModeBackgroundColor.withAlpha(2)
          : kWhiteLight.withAlpha(2),
      elevation: 0,
      actions: [
        // showBackButton == true
        // ?
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 5),
          child: GestureDetector(
            onTap: () {
              action ?? Get.back();
            },
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: kBodyTextFont,
                    color: isDarkMood ? kWhiteLight : kBlackDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
        // : Container()
        ,
      ],
    );
  }
}

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({
//     super.key,
//     required this.isDarkMood,
//   });

//   final bool isDarkMood;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: isDarkMood
//           ? kDarkModeBackgroundColor.withAlpha(2)
//           : kWhiteLight.withAlpha(2),
//       elevation: 0,
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 16.0, top: 5),
//           child: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Icon(Icons.arrow_back_ios),
//                 ),
//                 const SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: isDarkMood ? kWhiteLight : kBlackDark,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
