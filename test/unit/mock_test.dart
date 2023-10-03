// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:spacemall/src/features/core_app/store/screens/store_screen.dart';
// // Define mock classes for Firebase
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// void main() {
//   test('Phone auth with Firebase', () async {
//     final authService = AuthService();
//     final mockFirebaseAuth =
//         MockFirebaseAuth(); // Create a mock FirebaseAuth instance

//     // Define expected values for the mockFirebaseAuth methods
//     final verificationId = 'test_verification_id';
//     final phoneNumber = '+1234567890';

//     // Set up mock responses for verifyPhoneNumber
//     when(mockFirebaseAuth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int? forceResendingToken) {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     )).thenAnswer((_) async => verificationId);

//     // Override the _auth instance in the authService with the mock instance
//     authService.auth = mockFirebaseAuth;

//     // Test the signInWithPhoneNumber function
//     final result = await authService.signInWithPhoneNumber(phoneNumber);

//     // Expect 'success' as the result since we mocked Firebase's behavior
//     expect(result, 'success');
//   });
// }


