import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/screens/on_boarding/on_boarding_screen.dart';
import 'package:spacemall/src/features/auth/screens/welcome/welcome.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  bool _isUserSignedIn = false;
  bool get isUserSignedIn => _isUserSignedIn;

  String? _uid;
  String get uid => _uid ?? '';

  String? userPhone = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser!.phoneNumber
      : '';

  String? _profilePic;
  String get profilePic => _profilePic?.toString() ?? '';

  String? _phoneNumber;
  String? get phoneNumber =>
      _phoneNumber?.toString() ?? _auth.currentUser?.phoneNumber;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
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

  Future<void> phoneAuth(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendId) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid phone number') {
          Get.snackbar('Error', 'The provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    checkExistingUser();
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp),
    );
    if (credentials.user != null) {
      credentials.user!.uid;
      _uid = credentials.user!.uid;
    }
    return credentials.user != null ? true : false;
  }

  Future<bool> checkExistingUser() async {
    // DocumentSnapshot snapshot =
    //     await _firestore.collection('users').doc(_uid).get();

    SharedPreferences access = await SharedPreferences.getInstance();

    String user = access.getString('uid') ?? '';

    // print(snapshot.data());

    if (user.isNotEmpty) {
      Get.snackbar(
        'Login successful',
        'Loged in as $user ',
        backgroundColor: kWhiteDark,
        colorText: kBlackDark,
      );

      return true;
    } else {
      Get.snackbar(
        'Welcome',
        'Welcom to spacemall ',
        backgroundColor: kWhiteDark,
        colorText: kBlackDark,
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
    access.setString('uid', AuthRepo.instance.uid);
    _isUserSignedIn = true;
  }

  // function to set user to signed in
  Future setSignedOut() async {
    final SharedPreferences access = await SharedPreferences.getInstance();
    access.setBool('user_signed_in', false);
    access.remove('uid');
    _isUserSignedIn = false;
  }

  Future<void> signOut() async => await _auth.signOut();

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
