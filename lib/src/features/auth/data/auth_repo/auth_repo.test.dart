// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:mockito/mockito.dart';
// import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';

// import '../../../core_app/profile/domain/user_model.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// void main() {
//   group('phoneAuth', () {
//     late AuthRepo authRepo;
//     late MockFirebaseAuth mockFirebaseAuth;

//     setUp(() {
//       mockFirebaseAuth = MockFirebaseAuth();
//       authRepo = AuthRepo(
//         mockFirebaseAuth,
//         UserModel(
//           cart: [],
//           stores: RxList([]),
//           profilePic: '',
//           bio: '',
//           createdAt: '',
//           email: '',
//           contactNumber: '',
//           country: '',
//           role: '',
//           uid: '',
//           userName: '',
//         ),
//       );
//     });

//     test('should return a verification id when phone number is valid',
//         () async {
//       // arrange
//       final phoneNo = '+1234567890';
//       final verificationId = '123456';
//       when(mockFirebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: (String verificationId, int? forceResendingToken) {},
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       )).thenAnswer((_) async => verificationId);

//       // act
//       final result = await authRepo.phoneAuth(phoneNo);

//       // assert
//       expect(result, equals(verificationId));
//       verify(mockFirebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: (String verificationId, int? forceResendingToken) {},
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       ));
//       verifyNoMoreInteractions(mockFirebaseAuth);
//     });

//     test('should throw an exception when phone number is invalid', () async {
//       // arrange
//       final phoneNo = 'invalid-phone-number';
//       when(mockFirebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: (String verificationId, int? forceResendingToken) {},
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       )).thenThrow(FirebaseAuthException(code: 'invalid-phone-number'));

//       // act
//       final call = authRepo.phoneAuth(phoneNo);

//       // assert
//       expect(call, throwsA(isA<FirebaseAuthException>()));
//       verify(mockFirebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: (String verificationId, int? forceResendingToken) {},
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       ));
//       verifyNoMoreInteractions(mockFirebaseAuth);
//     });
//   });
// }

// // codeSent: anyNamed('codeSent'),
// // codeAutoRetrievalTimeout: anyNamed('codeAutoRetrievalTimeout'),
// // ));
// verifyNoMoreInteractions(mockFirebaseAuth) => null;
//     // });
  // });
// }