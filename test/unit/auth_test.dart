// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// void main() {
//   // test('Phone auth with Firebase', () {
//   //   final authRepo = AuthRepo(
//   //     MockFirebaseAuth(),
//   //     UserModel(
//   //       cart: [],
//   //       stores: RxList([]),
//   //       profilePic: '',
//   //       bio: '',
//   //       createdAt: '',
//   //       email: '',
//   //       contactNumber: '',
//   //       country: '',
//   //       role: '',
//   //       uid: '',
//   //       userName: '',
//   //     ),
//   //   );
//   //   final mockFirebaseAuth = MockFirebaseAuth();

//   //   const verificationId = 'test_verification_id';
//   //   const phoneNumber = '+1234567890';

//   //   when(mockFirebaseAuth.verifyPhoneNumber(
//   //     phoneNumber: phoneNumber,
//   //     verificationCompleted: (PhoneAuthCredential credential) {
//   //       print('verificationCompleted');
//   //       return;
//   //     },
//   //     verificationFailed: (FirebaseAuthException e) {
//   //       print('verificationFailed');
//   //       return;
//   //     },
//   //     codeSent: (String verificationId, int? forceResendingToken) {
//   //       print('codeSent');
//   //       return;
//   //     },
//   //     codeAutoRetrievalTimeout: (String verificationId) {
//   //       print('codeAutoRetrievalTimeout');
//   //       return;
//   //     },
//   //   )).thenAnswer((_) async => verificationId);

//   //   authRepo.auth = mockFirebaseAuth;

//   //   final result = authRepo.signInWithPhone(phoneNumber);

//   //   expect(result, 'success');
//   // });

//   group('Mock Phone Authentication', () {
//     final provider = MockFirebaseAuth();
//     test('Provider should not be initialized at start', () {
//       expect(provider.isInitialized, false);
//     });
//     test('Can not sign out if not initialized', () {
//       expect(() => provider.signOut(),
//           throwsA(const TypeMatcher<NotInitializedException>()));
//     });

//     test('Provider should be able to be initialized', () async {
//       await provider.initialize();
//       expect(provider.isInitialized, true);
//     });

//     test('User should be null on initialization', () {
//       expect(provider.currentUser, isNull);
//     });

//     test(
//       'Should be initialized in less than 2 sec',
//       () async {
//         await provider.initialize();
//         expect(provider.isInitialized, true);
//       },
//       timeout: const Timeout(
//         Duration(seconds: 5),
//       ),
//     );

//     test('Bad signin', () async {
//       await provider.initialize();
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: 'frtverification_id',
//         smsCode: '123456',
//       );

//       try {
//         await provider.signInWithCredential(credential);
//         fail('Expected FirebaseAuthException was not thrown');
//       } catch (e) {
//         expect(e, isA<FirebaseAuthException>());
//       }
//     });

//     test('Provider should be able to sign in with phone number', () async {
//       await provider.initialize();
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: 'verification_id',
//         smsCode: '123456',
//       );
//       final result = await provider.signInWithCredential(credential);

//       expect(result, isNotNull);
//     });
  
//   // test('', () => null)
// });
// }

// class MockUserCredential extends Mock implements UserCredential {}

// class NotInitializedException implements Exception {}

// class MockFirebaseAuth implements FirebaseAuth {
//   User? _user;

//   var _isInitialized = false;
//   bool get isInitialized => _isInitialized;
//   @override
//   Stream<User?> authStateChanges() {
//     return Stream.value(MockUser(
//       isAnonymous: false,
//       uid: 'test_uid',
//       email: 'test_email',
//       displayName: 'test_display_name',
//       phoneNumber: 'test_phone_number',
//       photoURL: 'test_photo_url',
//     ));
//   }

//   @override
//   Future<UserCredential> signInWithCredential(AuthCredential credential) async {
//     if (!_isInitialized) throw NotInitializedException();

//     if (credential is PhoneAuthCredential) {
//       final String verificationId = credential.verificationId ?? '';
//       final String smsCode = credential.smsCode ?? '';

//       if (verificationId != 'verification_id') {
//         throw FirebaseAuthException(
//           code: 'invalid-verification-id',
//           message: 'Invalid verification ID',
//         );
//       }
//       if (smsCode != '123456') {
//         throw FirebaseAuthException(
//           code: 'invalid-sms-code',
//           message: 'Invalid SMS code',
//         );
//       }
//     }
//     _user = MockUserCredential().user;
//     return MockUserCredential();
//   }

//   verificationCompleted(PhoneAuthCredential credential) {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: 'verification_id',
//       smsCode: '123456',
//     );

//     return credential;
//   }

//   verificationFailed(FirebaseAuthException e) {
//     return FirebaseAuthException;
//   }

//   codeSent(String verificationId, int? forceResendingToken) {
//     return verificationId;
//   }

//   codeAutoRetrievalTimeout(String verificationId) {
//     return verificationId;
//   }

//   @override
//   Future<void> verifyPhoneNumber(
//       {String? phoneNumber,
//       PhoneMultiFactorInfo? multiFactorInfo,
//       required PhoneVerificationCompleted verificationCompleted,
//       required PhoneVerificationFailed verificationFailed,
//       required PhoneCodeSent codeSent,
//       required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
//       String? autoRetrievedSmsCodeForTesting,
//       Duration timeout = const Duration(seconds: 30),
//       int? forceResendingToken,
//       MultiFactorSession? multiFactorSession}) async {
//     PhoneAuthCredential phoneAuthCredential;

//     if (phoneNumber == '1234567890') {
//       verificationCompleted(PhoneAuthCredential credential) {
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: 'verification_id',
//           smsCode: '123456',
//         );

//         return credential;
//       }

//       verificationFailed(FirebaseAuthException e) {
//         return FirebaseAuthException;
//       }

//       codeSent(String verificationId, int? forceResendingToken) {
//         return verificationId;
//       }

//       codeAutoRetrievalTimeout(String verificationId) {
//         return verificationId;
//       }

//       await Future.delayed(const Duration(seconds: 2));

//       // signInWithCredential(phoneAuthCredential);
//     }

//     throw FirebaseAuthException(code: 'invalid-phone-number');
//   }

//   @override
//   late FirebaseApp app;

//   @override
//   String? tenantId;

//   Future<void> initialize() async {
//     await Future.delayed(const Duration(seconds: 2));
//     _isInitialized = true;
//   }

//   @override
//   Future<void> applyActionCode(String code) {
//     // TODO: implement applyActionCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<ActionCodeInfo> checkActionCode(String code) {
//     // TODO: implement checkActionCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> confirmPasswordReset(
//       {required String code, required String newPassword}) {
//     // TODO: implement confirmPasswordReset
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> createUserWithEmailAndPassword(
//       {required String email, required String password}) {
//     // TODO: implement createUserWithEmailAndPassword
//     throw UnimplementedError();
//   }

//   @override
//   User? get currentUser => _user;

//   @override
//   Future<List<String>> fetchSignInMethodsForEmail(String email) {
//     // TODO: implement fetchSignInMethodsForEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> getRedirectResult() {
//     // TODO: implement getRedirectResult
//     throw UnimplementedError();
//   }

//   @override
//   Stream<User?> idTokenChanges() {
//     // TODO: implement idTokenChanges
//     throw UnimplementedError();
//   }

//   @override
//   bool isSignInWithEmailLink(String emailLink) {
//     // TODO: implement isSignInWithEmailLink
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement languageCode
//   String? get languageCode => throw UnimplementedError();

//   @override
//   // TODO: implement pluginConstants
//   Map get pluginConstants => throw UnimplementedError();

//   @override
//   Future<void> revokeTokenWithAuthorizationCode(String authorizationCode) {
//     // TODO: implement revokeTokenWithAuthorizationCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> sendPasswordResetEmail(
//       {required String email, ActionCodeSettings? actionCodeSettings}) {
//     // TODO: implement sendPasswordResetEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> sendSignInLinkToEmail(
//       {required String email, required ActionCodeSettings actionCodeSettings}) {
//     // TODO: implement sendSignInLinkToEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setLanguageCode(String? languageCode) {
//     // TODO: implement setLanguageCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setPersistence(Persistence persistence) {
//     // TODO: implement setPersistence
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setSettings(
//       {bool appVerificationDisabledForTesting = false,
//       String? userAccessGroup,
//       String? phoneNumber,
//       String? smsCode,
//       bool? forceRecaptchaFlow}) {
//     // TODO: implement setSettings
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInAnonymously() {
//     // TODO: implement signInAnonymously
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithAuthProvider(AuthProvider provider) {
//     // TODO: implement signInWithAuthProvider
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithCustomToken(String token) {
//     // TODO: implement signInWithCustomToken
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithEmailAndPassword(
//       {required String email, required String password}) {
//     // TODO: implement signInWithEmailAndPassword
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithEmailLink(
//       {required String email, required String emailLink}) {
//     // TODO: implement signInWithEmailLink
//     throw UnimplementedError();
//   }

//   @override
//   Future<ConfirmationResult> signInWithPhoneNumber(String phoneNumber,
//       [RecaptchaVerifier? verifier]) {
//     // TODO: implement signInWithPhoneNumber
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithPopup(AuthProvider provider) {
//     // TODO: implement signInWithPopup
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithProvider(AuthProvider provider) {
//     // TODO: implement signInWithProvider
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signInWithRedirect(AuthProvider provider) {
//     // TODO: implement signInWithRedirect
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signOut() {
//     if (!_isInitialized) throw NotInitializedException();
//     if (_user == null) throw FirebaseAuthException(code: 'user-not-found');
//     _user = null;
//     _isInitialized;
//     return Future.value();
//   }

//   @override
//   Future<void> useAuthEmulator(String host, int port) {
//     // TODO: implement useAuthEmulator
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> useEmulator(String origin) {
//     // TODO: implement useEmulator
//     throw UnimplementedError();
//   }

//   @override
//   Stream<User?> userChanges() {
//     // TODO: implement userChanges
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> verifyPasswordResetCode(String code) {
//     // TODO: implement verifyPasswordResetCode
//     throw UnimplementedError();
//   }
// }
