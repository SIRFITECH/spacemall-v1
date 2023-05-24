import 'package:flutter/material.dart';

class SpacenallDrawer extends StatelessWidget {
  const SpacenallDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('drawer widget');
    //  Drawer(
    //   backgroundColor: kMainColor,
    //   child: ListView(children: [
    //     Column(
    //       children: <Widget>[
    //         UserAccountsDrawerHeader(
    //           accountName:
    //               // Text('Name Of Owner'),
    //               Text(
    //             '${ap.userModel.firstName.toUpperCase()} ${ap.userModel.lastName.toUpperCase()}',
    //           ),
    //           accountEmail:
    //               // Text("emailofowner@gmail.com"),
    //               Text(ap.userModel.email),
    //           currentAccountPicture: CircleAvatar(
    //             radius: 100,
    //             backgroundColor: Colors.transparent,
    //             child: SizedBox(
    //                 child: ClipOval(
    //               child: CircleAvatar(
    //                 radius: 100,
    //                 backgroundColor: kMainColor.withOpacity(.01),
    //                 backgroundImage: NetworkImage(
    //                   ap.userModel.profilePic,
    //                 ),
    //               ),
    //               // Image.asset('images/mosnyik.jpeg'),
    //             )),
    //           ),
    //           otherAccountsPictures: [
    //             CircleAvatar(
    //               radius: 100,
    //               backgroundColor: Colors.transparent,
    //               child: SizedBox(
    //                   child: ClipOval(
    //                 child: Image.asset('images/insta.png'),
    //               )),
    //             ),
    //             CircleAvatar(
    //               radius: 100,
    //               backgroundColor: Colors.transparent,
    //               child: SizedBox(
    //                   child: ClipOval(
    //                 child: Image.asset('images/linkedin.png'),
    //               )),
    //             ),
    //             CircleAvatar(
    //               radius: 100,
    //               backgroundColor: Colors.transparent,
    //               child: SizedBox(
    //                   child: ClipOval(
    //                 child: Image.asset('images/insta.png'),
    //               )),
    //             ),
    //             CircleAvatar(
    //               radius: 100,
    //               backgroundColor: Colors.transparent,
    //               child: SizedBox(
    //                   child: ClipOval(
    //                 child: Image.asset('images/linkedin.png'),
    //               )),
    //             ),
    //           ],
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             ListTile(
    //               onTap: () {
    //                 Navigator.pushNamed(context, Home.id);
    //               },
    //               leading: const Icon(
    //                 Icons.home_filled,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Home', style: kDrawerTextStyle),
    //             ),
    //             const Divider(
    //               color: kWhite,
    //               indent: 16,
    //               endIndent: 16,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 Navigator.pushNamed(context, Profile.id);
    //               },
    //               leading: const Icon(
    //                 Icons.person,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Profile', style: kDrawerTextStyle),
    //             ),
    //             const Divider(
    //               color: kWhite,
    //               indent: 16,
    //               endIndent: 16,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 Navigator.pushNamed(context, SettingsHome.id);
    //               },
    //               leading: const Icon(
    //                 Icons.settings,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Settings', style: kDrawerTextStyle),
    //             ),
    //             const Divider(
    //               color: kWhite,
    //               indent: 16,
    //               endIndent: 16,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 Navigator.pushNamed(context, AddNewStore.id);
    //               },
    //               leading: const Icon(
    //                 Icons.storefront_rounded,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Add New Store', style: kDrawerTextStyle),
    //             ),
    //             const Divider(
    //               color: kWhite,
    //               indent: 16,
    //               endIndent: 16,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 Navigator.pushNamed(context, Help.id);
    //               },
    //               leading: const Icon(
    //                 Icons.info,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Help', style: kDrawerTextStyle),
    //             ),
    //             const Divider(
    //               color: kWhite,
    //               indent: 16,
    //               endIndent: 16,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 ap.signOut();
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => const SignIn(),
    //                   ),
    //                 );
    //                 // print('Signed out');
    //               },
    //               leading: const Icon(
    //                 Icons.logout_outlined,
    //                 color: kWhite,
    //               ),
    //               title: const Text('Sign Out', style: kDrawerTextStyle),
    //             ),
    //             const SizedBox(height: 200),
    //             const Padding(
    //               padding: EdgeInsets.all(16.0),
    //               child: Icon(
    //                 Icons.lightbulb_outline_sharp,
    //                 color: kWhite,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     )
    //   ]),
    // );
  }
}
