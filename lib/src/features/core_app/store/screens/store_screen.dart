// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mockito/mockito.dart'; // Import mockito for mocking Firebase

// class AuthService {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   Future<String?> signInWithPhoneNumber(String phoneNumber) async {
//     try {
//       verificationCompleted(PhoneAuthCredential authCredential) async {
//         await auth.signInWithCredential(authCredential);
//       }

//       verificationFailed(FirebaseAuthException e) {
//         // Handle verification failure
//         return null; // You can return an error message here
//       }

//       codeSent(String verificationId, int? resendToken) {
//         // Handle code sent
//       }

//       codeAutoRetrievalTimeout(String verificationId) {
//         // Handle timeout
//       }

//       await auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//       );

//       return 'success'; // Return a success message if everything goes well
//     } catch (e) {
//       return null; // Return an error message if there's an exception
//     }
//   }
// }

// // Example test using mockito

