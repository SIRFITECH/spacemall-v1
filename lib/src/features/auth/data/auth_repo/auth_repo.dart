import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/auth/screens/on_boarding/on_boarding_screen.dart';
import 'package:spacemall/src/features/auth/screens/welcome/welcome.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import '../../../core_app/profile/application/profile_controller.dart';
import '../../../core_app/profile/screens/set_profile.dart';

class AuthRepo extends GetxController {
  /// I want to make this class testable
  ///

  FirebaseAuth auth;
  UserModel user;

  AuthRepo(this.auth, this.user);
  static AuthRepo get instance => Get.find();
  Stream<User?> get signInUser => auth.authStateChanges();

  Future<String> signInWithPhone(String phoneNo) async {
    return await Future.value('success');
  }

  // IMPORTANTS ABOVE

  Rx<User?> firebaseUser = Rx<User?>(null);
  var verificationId = ''.obs;

  bool _isUserSignedIn = false;
  bool get isUserSignedIn => _isUserSignedIn;

  String? _uid;
  String get uid => _uid ?? '';

  String? _profilePic;
  String get profilePic => _profilePic?.toString() ?? '';

  String? _phoneNumber;
  String? get phoneNumber =>
      _phoneNumber?.toString() ?? auth.currentUser?.phoneNumber;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
    checkInternetConnection();
  }

  _setInitialScreen(User? user) {
    // user == null
    //     ? Get.offAll(() => const Welcome())
    //     : Get.offAll(() => DashBoard());

    if (user == null) {
      Get.offAll(() => const Welcome());
    } else if (user.uid.isEmpty || user.photoURL!.isEmpty) {
      Get.offAll(() => const OnBoarding());
    } else {
      Get.offAll(() => DashBoard());
    }
  }

  // Future<bool> userAlreadyExists(String? phone) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithPhoneNumber(phone!, RecaptchaVerifier(auth: ));
  //     print('This user already exist');
  //     return true;
  //   } catch (e) {
  //     print('This is a new user ${e.toString()}');
  //     return false;
  //   }
  // }

  void catchLoginError(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Invalid phone number',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'The phone number provided is invalid, check and try again',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'account-exists-with-different-credential') {
      //  fetch already existing accounts using auth.fetchSignInMethodsForEmail;
      // and ask user to sign in with the existing account then
      //link their account with the existing account

      Get.dialog(
        AlertDialog(
          title: const Text(
            'Account exists with different credential',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please try again with the correct credentials',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'operation-not-allowed') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'You can not perform this operation',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please contact customer support',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'user-disabled') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'You user-disabled ',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please contact customer support',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'user-disabled') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Your account is disabled ',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please contact customer support',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'invalid-verification-code') {
      OtpController.instance.isLoading.value = false;
      Get.snackbar('Invalid Code', 'You have an invalid verification code',
          colorText: Colors.white, backgroundColor: Colors.red);

      // Get.dialog(
      //   AlertDialog(
      //     title: const Text(
      //       'You have an invalid verification code ',
      //       style: TextStyle(color: kBlack),
      //     ),
      //     content: const Text(
      //       'Please try again',
      //       style: TextStyle(color: kBlack),
      //     ),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           // OtpController.instance.isLoading.value = false;
      //           Get.off(
      //             () => const OTPScreen(),
      //           );
      //         },
      //         child: const Text('Ok'),
      //       ),
      //     ],
      //   ),
      // );
    } else if (e.code == 'invalid-verification-id') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'You have an invalid verification id',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please re try the login',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'session-expired') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Your session has expired',
            style: TextStyle(color: kBlack),
          ),
          content: const Text(
            'Please re try the login',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(
                  () => const Login(),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<String> phoneAuth(String phoneNo) async {
    OtpController.instance.isLoading.value = true;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential

          await auth.signInWithCredential(credential);

          // RecaptchaVerifier(
          //   container: null, // Provide a container if needed for web
          //   size: RecaptchaVerifierSize.normal,
          //    theme: RecaptchaVerifierTheme.dark, auth:,
          // );

          // check if user is logged in already using uid
          // and use the uid to link the account
        },

        verificationFailed: (FirebaseAuthException e) {
          catchLoginError(e);
        },

        codeSent: (String verificationId, int? resendToken) async {
          Get.snackbar('Code sent', 'You should',
              colorText: Colors.white, backgroundColor: Colors.green);
          // String smsCode = OtpController.instance.otp.value;
          resendToken = OtpController.instance.resendToken.value;
          this.verificationId.value = verificationId;

          // // Create a PhoneAuthCredential with the code
          // PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          // print('THIS USER HAS THE ACCESS CODE OF $verificationId');
          // print('smsCode is $smsCode and resendToken is $resendToken');
          // credential.smsCode;

          // Sign the user in (or link) with the credential
          // try {
          //   await auth.signInWithCredential(credential);
          // } catch (e) {
          //   Get.snackbar('Login Error', e.toString(),
          //       colorText: Colors.white, backgroundColor: Colors.red);
          // }
          // check if user is logged in already using uid
          // and use the uid to link the account
        },

        // code auto retrieval timeout
        timeout: const Duration(seconds: 30),
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );

      OtpController.instance.isLoading.value = false;
      return 'success';
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    OtpController.instance.isLoading.value = false;
    return 'error';
  }

  resendOTP() {
    if (ProfileController.instance.contactNumber != null) {
      phoneAuth(ProfileController.instance.contactNumber!);
      OtpController.instance.setTimer();
    } else {
      Get.snackbar('No phone number',
          'Please go back to Login page and add your phone number');
    }
  }

  Future<void> signInWithGoogle() async {
    // OtpController.instance.isLoading.value = true;
    // if (user.uid.isNotEmpty) {
    //   print(user.uid);
    // } else {
    //   print('user model is null');
    // }

    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      // FirebaseAuth.instance.userChanges().listen(
      //   (User? googleSignInAccount) {
      //     if (googleSignInAccount == null) {
      //       print('User is currently signed out!');
      //     } else {
      //       print('User is signed in!');
      //     }
      //   },
      // );
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        _uid = userCredential.user?.uid ?? '';
        // String photoURL = userCredential.user?.photoURL ?? '';
        ProfileController.instance.tUserName.text =
            userCredential.user?.displayName ?? '';
        ProfileController.instance.tEmail.text =
            userCredential.user?.email ?? '';
        // ProfileController.instance.profilePic.value = photoURL as File?;
        Get.snackbar(
          'Login successful',
          'What is left is to go to profile to add your number and bio',
          backgroundColor: kWhiteDark,
          colorText: kBlackDark,
        );
        ProfileController.instance.contactNumber = '';

        var exists = AuthRepo.instance.profilePic.isNotEmpty;
        AuthRepo.instance.setSignedIn();

        // isVerified &&
        exists
            ? Get.offAll(
                () => DashBoard(),
              )
            : Get.offAll(
                () => const SetProfile(),
              );
        OtpController.instance.isLoading.value = false;
      } else {
        Get.snackbar(
          'Login Error',
          'Something went wrong, check your connection',
          backgroundColor: kRedColor,
          colorText: kWhiteLight,
        );
      }
    } catch (e) {
      OtpController.instance.isLoading.value = false;
      Get.snackbar(
        'Login Cancelled',
        'Login terminated',
        backgroundColor: kRedColor,
        colorText: kWhiteLight,
      );
      // catchLoginError(e);
    }
  }

  Future<void> signInWithFacebook() async {
    OtpController.instance.isLoading.value = true;
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      // final userData = await FacebookAuth.instance.getUserData();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      _uid = userCredential.user?.uid ?? '';

      ProfileController.instance.tUserName.text =
          userCredential.user?.displayName ?? '';
      ProfileController.instance.tEmail.text = userCredential.user?.email ?? '';

      Get.snackbar(
        'Login successful',
        'What is left is to go to profile to add your number and bio',
        backgroundColor: kWhiteDark,
        colorText: kBlackDark,
      );

      ProfileController.instance.contactNumber = '';

      var exists = AuthRepo.instance.profilePic.isNotEmpty;
      AuthRepo.instance.setSignedIn();
      exists
          ? Get.offAll(
              () => DashBoard(),
            )
          : Get.offAll(
              () => const SetProfile(),
            );
      OtpController.instance.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      OtpController.instance.isLoading.value = false;
      catchLoginError(e);
    }
  }

  Future<void> signInWithTwitter() async {
    Get.snackbar('Login Mode Down', 'Please try another login method',
        colorText: Colors.white, backgroundColor: Colors.red);
    // OtpController.instance.isLoading.value = true;
    // // Create a TwitterLogin instance
    // try {
    //   final twitterLogin = new TwitterLogin(
    //       apiKey: '<your consumer key>',
    //       apiSecretKey: ' <your consumer secret>',
    //       redirectURI: '<your_scheme>://');

    //   // Trigger the sign-in flow
    //   final authResult = await twitterLogin.login();

    //   // Create a credential from the access token
    //   final twitterAuthCredential = TwitterAuthProvider.credential(
    //     accessToken: authResult.authToken!,
    //     secret: authResult.authTokenSecret!,
    //   );

    //   print('twitter login success ${twitterAuthCredential}');

    //   // // Once signed in, return the UserCredential
    //   // return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    //   OtpController.instance.isLoading.value = false;
    // }on FirebaseAuthException catch (e) {
    //   OtpController.instance.isLoading.value = false;
    //   catchLoginError(e);
    // }
  }

  Future<void> signInWithInsta() async {
    Get.snackbar('Login Mode Down', 'Please try another login method',
        colorText: Colors.white, backgroundColor: Colors.red);
    // OtpController.instance.isLoading.value = true;
    // // Create a TwitterLogin instance
    // try {
    //   final twitterLogin = new TwitterLogin(
    //       apiKey: '<your consumer key>',
    //       apiSecretKey: ' <your consumer secret>',
    //       redirectURI: '<your_scheme>://');

    //   // Trigger the sign-in flow
    //   final authResult = await twitterLogin.login();

    //   // Create a credential from the access token
    //   final twitterAuthCredential = TwitterAuthProvider.credential(
    //     accessToken: authResult.authToken!,
    //     secret: authResult.authTokenSecret!,
    //   );

    //   print('twitter login success ${twitterAuthCredential}');

    //   // // Once signed in, return the UserCredential
    //   // return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    //   OtpController.instance.isLoading.value = false;
    // } on FirebaseAuthException catch (e) {
    //   OtpController.instance.isLoading.value = false;
    //   catchLoginError(e);
    // }
  }

  Future<void> signInWithMetaMask() async {
    Get.snackbar('Login Mode Down', 'Please try another login method',
        colorText: Colors.white, backgroundColor: Colors.red);
    // OtpController.instance.isLoading.value = true;
    // // Create a TwitterLogin instance
    // try {
    //   final twitterLogin = new TwitterLogin(
    //       apiKey: '<your consumer key>',
    //       apiSecretKey: ' <your consumer secret>',
    //       redirectURI: '<your_scheme>://');

    //   // Trigger the sign-in flow
    //   final authResult = await twitterLogin.login();

    //   // Create a credential from the access token
    //   final twitterAuthCredential = TwitterAuthProvider.credential(
    //     accessToken: authResult.authToken!,
    //     secret: authResult.authTokenSecret!,
    //   );

    //   print('twitter login success ${twitterAuthCredential}');

    //   // // Once signed in, return the UserCredential
    //   // return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    //   OtpController.instance.isLoading.value = false;
    // } catch (e) {
    //   OtpController.instance.isLoading.value = false;
    //   if (e.toString().contains('null')) {
    //     Get.snackbar('Login cancelled', 'You cancelled the login process');
    //   }
    //   Get.snackbar('Login Error', e.toString());
    // }
  }

  Future<bool> verifyOTP(String otp) async {
    OtpController.instance.isLoading.value = true;
    checkExistingUser();
    var credentials = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp),
    );
    if (credentials.user != null) {
      credentials.user!.uid;
      _uid = credentials.user!.uid;
    }
    OtpController.instance.isLoading.value = false;
    return credentials.user != null ? true : false;
  }

  Future<bool> checkExistingUser() async {
    // DocumentSnapshot snapshot =
    //     await _firestore.collection('users').doc(_uid).get();

    SharedPreferences access = await SharedPreferences.getInstance();

    String user = access.getString('uid') ?? '';

    if (user.isNotEmpty) {
      Get.snackbar(
        'Login successful',
        'Loged in as $user ',
        backgroundColor: kWhiteDark,
        colorText: kBlackDark,
      );

      return true;
    } else {
      // Get.snackbar(
      //   'Welcome',
      //   'Welcom to spacemall ',
      //   backgroundColor: kWhiteDark,
      //   colorText: kBlackDark,
      // );

      return false;
    }
  }

  // function to check if user is signed in
  Future checkSignedIn() async {
    final SharedPreferences access = await SharedPreferences.getInstance();
    _isUserSignedIn = access.getBool('user_signed_in') ?? false;
  }

  // function to set user to signed in
  Future setSignedIn() async {
    final SharedPreferences access = await SharedPreferences.getInstance();
    access.setBool('user_signed_in', true);
    access.setString('loginToken', AuthRepo.instance.uid);
    access.setString('uid', AuthRepo.instance.uid);
    _isUserSignedIn = true;
  }

  // function to set user to signed in
  Future setSignedOut() async {
    final SharedPreferences access = await SharedPreferences.getInstance();
    access.setBool('user_signed_in', false);
    // access.remove('uid');
    // ProfileRepo.instance.clearFeilds();
    _isUserSignedIn = false;
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
    await setSignedOut();
    Get.offAll(() => const Login());
  }

  Future<void> checkInternetConnection() async {
    var connectivityStatus = await (Connectivity().checkConnectivity());
    if (connectivityStatus != ConnectivityResult.mobile ||
        connectivityStatus != ConnectivityResult.wifi ||
        connectivityStatus != ConnectivityResult.ethernet) {
    } else {
      Get.snackbar('No internet connection',
          'Please make sufe you are connected to internet');
    }
  }
}
