import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/auth/screens/on_boarding/on_boarding_screen.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_screen.dart';
import 'package:spacemall/src/features/auth/screens/welcome/welcome.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/services/network_connectivity/network_connectivity.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';
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

  // Future<String> signInWithPhone(String phoneNo) async {
  //   return await Future.value('success');
  // }

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
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'The phone number provided is invalid, check and try again',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                LoginController.instance.isLoading.value = false;
                Get.back();
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
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Please try again with the correct credentials',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
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
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Please contact customer support',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                LoginController.instance.isLoading.value = false;
                Get.back();
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
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Please contact customer support',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                LoginController.instance.isLoading.value = false;
                Get.back();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (e.code == 'invalid-verification-code') {
      OtpController.instance.isLoading.value = false;
      spaceMallSnackBar(
        'Invalid Code',
        'You have an invalid verification code',
        kWhiteLight,
        kRedColor,
      );
    } else if (e.code == 'invalid-verification-id') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'You have an invalid verification id',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Please re try the login',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                LoginController.instance.isLoading.value = false;
                Get.back();
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  fontSize: kBodyTextFont,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (e.code == 'session-expired') {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Your session has expired',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Please re try the login',
            style: TextStyle(
              color: kBlack,
              fontSize: kBodyTextFont,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                LoginController.instance.isLoading.value = false;
                Get.back();
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: kBlack,
                  fontSize: kBodyTextFont,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      LoginController.instance.isLoading.value = false;

      spaceMallSnackBar(
        'Try Again Later',
        '${e.message}',
        kWhiteLight,
        kRedColor,
      );
      // print(' the error message is: ${e.message}');
    }
  }

// Resend OTP if it failed the first time
  resendOTP() {
    if (ProfileController.instance.contactNumber != null) {
      phoneAuth(ProfileController.instance.contactNumber!);
      OtpController.instance.resetTimer();
      spaceMallSnackBar(
        'Resend OTP initiated',
        'You have intiated resend OTP, you should soon recieve an OTP on your phone',
        kWhiteLight,
        kGreenColor,
      );
    } else {
      spaceMallSnackBar(
        'No phone number',
        'Please go back to Login page and add your phone number',
        kWhiteLight,
        kRedColor,
      );
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

        spaceMallSnackBar(
          'Login successful',
          'What is left is to go to profile to add your number and bio',
          kBlackDark,
          kWhiteDark,
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
        spaceMallSnackBar(
          'Login Error',
          'Something went wrong, check your connection',
          kWhiteLight,
          kRedColor,
        );
      }
    } catch (e) {
      OtpController.instance.isLoading.value = false;
      spaceMallSnackBar(
        'Login Cancelled',
        'Login terminated',
        kWhiteLight,
        kRedColor,
      );
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
      spaceMallSnackBar(
        'Login successful',
        'What is left is to go to profile to add your number and bio',
        kBlackDark,
        kWhiteDark,
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
    spaceMallSnackBar(
      'Login Mode Down',
      'Please try another login method',
      kWhiteLight,
      kRedColor,
    );

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
    spaceMallSnackBar(
      'Login Mode Down',
      'Please try another login method',
      kWhiteLight,
      kRedColor,
    );

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
    spaceMallSnackBar(
      'Login Mode Down',
      'Please try another login method',
      kWhiteLight,
      kRedColor,
    );

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
    bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();
    if (deviceHasInternet) {
      checkExistingUser();
      var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );
      if (credentials.user != null) {
        credentials.user!.uid;
        _uid = credentials.user!.uid;
      }
      if (credentials.user != null) {
        credentials.user!.uid;
        debugPrint('the user email is: ${credentials.user!.email}');
      }

      return credentials.user != null ? true : false;
    } else {
      OtpController.instance.isLoading.value = false;

      return false;
    }

    // OtpController.instance.isLoading.value = false;
  }

  //  await client.SignInWithRedirectAsync(FirebaseProviderType.Google, async uri =>
  //           {
  //               var options = new WebAuthenticatorOptions
  //               {
  //                   Url = new Uri(uri),
  //                   CallbackUrl = new Uri("com.companyname.myappname://callback/"),
  //                   PrefersEphemeralWebBrowserSession= true
  //               };

  //               var res = await WebAuthenticator.Default.AuthenticateAsync(options);
  //           });

  Future<String> phoneAuth(String phoneNo) async {
    OtpController.instance.isLoading.value = true;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          // spaceMallSnackBar(
          //   'An Error occured',
          //   '${e.message}',
          //   kWhiteLight,
          //   kRedColor,
          // );
          catchLoginError(e);
        },

        codeSent: (String verificationId, int? resendToken) async {
          // tell the user that the code has been sent to device
          spaceMallSnackBar(
            'Code sent',
            'Check your phone for the OTP',
            kWhiteLight,
            kGreenColor,
          );

          // String smsCode = OtpController.instance.otp.value;
          resendToken = OtpController.instance.resendToken.value;
          this.verificationId.value = verificationId;
          OtpController.instance.setTimer();
          LoginController.instance.isLoading.value = false;

          Get.offAll(
            () => const OTPScreen(),
          );
        },

        // code auto retrieval timeout
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );

      OtpController.instance.isLoading.value = false;
      return 'success';
    } on FirebaseAuthException catch (e) {
      spaceMallSnackBar(
        'Login Error',
        e.toString(),
        kWhiteLight,
        kRedColor,
      );
    }
    OtpController.instance.isLoading.value = false;
    return 'error';
  }

  Future<bool> checkExistingFirebaseUser(String userid) async {
    // Implement logic to check if the user already exists in your database
    // You might query your user database based on the phone number or UID

    // For example, you can use Firebase Firestore
    // Replace 'usersCollection' and 'phoneNumberField' with your actual collection and field names
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where(uid, isEqualTo: userid)
        .get();

    // .where('phoneNumberField', isEqualTo: phoneNumber)
    // .get();

    // Return true if the user already exists, false otherwise
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> checkExistingUser() async {
    // DocumentSnapshot snapshot =
    //     await _firestore.collection('users').doc(_uid).get();

    SharedPreferences access = await SharedPreferences.getInstance();

    String user = access.getString('uid') ?? '';

    if (user.isNotEmpty) {
      spaceMallSnackBar(
        'Login successful',
        'Loged in as $user ',
        kWhiteDark,
        kBlackDark,
      );

      return true;
    } else {
      spaceMallSnackBar(
        'Welcome Onboard',
        'You have created your account',
        kWhiteDark,
        kBlackDark,
      );

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
    try {
      // FIXME: remain on the same screen if there is no internet
      bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();
      if (deviceHasInternet) {
        await GoogleSignIn().signOut();
        await auth.signOut();
        await setSignedOut();
        Get.off(
          () => const Login(),
        );
      }
    } catch (e) {
      spaceMallSnackBar(
        'Error on Signout',
        '$e',
        kWhiteLight,
        kRedColor,
      );
    }
  }

  Future<void> checkInternetConnection() async {
    var connectivityStatus = await (Connectivity().checkConnectivity());
    if (connectivityStatus != ConnectivityResult.mobile ||
        connectivityStatus != ConnectivityResult.wifi ||
        connectivityStatus != ConnectivityResult.ethernet) {
    } else {
      spaceMallSnackBar(
        'No internet connection',
        'Please make sure you are connected to internet',
        kWhiteLight,
        kRedColor,
      );
    }
  }
}
