import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/screens/set_profile.dart';

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
    return 
  //   FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // while waiting for app to fetch user data from firebase
          return Container(
            decoration: const BoxDecoration(color: kWhiteLight),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
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
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (userSnapshot.hasData && userSnapshot.data != null) {
                // userSnapshot.data!
                return DashBoard();
              } else {
                return const SetProfile();
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
