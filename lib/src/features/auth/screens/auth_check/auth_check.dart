import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/auth/screens/on_boarding/on_boarding_screen.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen_loader.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';

// class AuthCheckScreen extends StatelessWidget {
//   const AuthCheckScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasData && snapshot.data != null) {
//           return DashBoard();
//         } else {
//           return const Login();
//         }
//         //  if (userSnapshot.connectionState == ConnectionState.waiting) {
//         //         // Show a loading indicator while fetching user details
//         //         return CircularProgressIndicator();
//         //       } else if (userSnapshot.hasData && userSnapshot.data != null) {
//         //         // User details exist, navigate to the main content
//         //         return HomeScreen(userSnapshot.data!);
//         //       } else {
//         //         // User details do not exist, navigate to create profile
//         //         return CreateProfileScreen();
//         //       }
//         //     },
//         //   );
//         // } else {
//         //   // User is not logged in, navigate to the login or onboarding screen
//         //   return LoginScreen();
//         // }
//       },
//     );
//   }
// }

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // while waiting for app to fetch user data from firebase
          return Container(
            decoration: const BoxDecoration(color: kWhiteLight),
            child: const SplascreenLoader(),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          // if user exists and has data
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data!.uid)
                .get(),
            builder: (context, userSnapshot) {
              // while waiting for app to fetch user data from firebase
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  decoration: const BoxDecoration(color: kWhiteLight),
                  child: const SplascreenLoader(),
                );
              } else if (userSnapshot.hasData &&
                  userSnapshot.data!.data() != null) {
                // this means user has created a profile
                // List<dynamic> storeUIDs = userSnapshot.data!.get('storeUIDs');
                // for (var uid in storeUIDs) {
                //   print(uid);
                // }

                // LoginController.instance.sendLoginMail();
                return DashBoard();
              } else {
                // user has not created a profile
                return const OnBoarding();
              }
            },
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
