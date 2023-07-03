import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.isDarkMood,
    required this.title,
    required this.automaticallyImplyLeading,
  });
  // : super(key: key);

  final bool isDarkMood;
  final String title;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      title: Text(title.toUpperCase()),
      titleTextStyle: TextStyle(
          color: isDarkMood ? kWhiteLight : kMainComplimemtColorLight,
          fontSize: 23,
          fontWeight: FontWeight.bold),
      backgroundColor: isDarkMood
          ? kDarkModeBackgroundColor.withAlpha(2)
          : kWhiteLight.withAlpha(2),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 5),
          child: GestureDetector(
            onTap: () {
              Get.back();
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
                    fontSize: 15,
                    color: isDarkMood ? kWhiteLight : kBlackDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
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
