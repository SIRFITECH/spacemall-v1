import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/services/network_connectivity/network_connectivity.dart';
import 'package:mailer/mailer.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  RxString phone = ''.obs;
  TextEditingController phoneController = TextEditingController();
  RxBool isLoading = false.obs;

  Rx<Country> country = Country(
    phoneCode: '234',
    countryCode: 'NGN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Nigeria',
    example: 'Nigeria',
    displayName: 'Nigeria',
    displayNameNoCountryCode: 'NGN',
    e164Key: '',
  ).obs;

  void setPickedCountry(BuildContext context) {
    return showCountryPicker(
      countryListTheme: CountryListThemeData(
          textStyle: Theme.of(context).textTheme.labelSmall,
          searchTextStyle: Theme.of(context).textTheme.labelSmall,
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.55),
      context: context,
      onSelect: (value) => country.value = value,
    );
  }

  void onSend() {
    phone.value =
        '+${country.value.phoneCode} ${phoneController.value.text.trim()}';
  }

  void signUserInWithPhone(String phoneNumber) async {
    bool deviceHasInternet = await NetworkConnectivity().deviceHasInternet();
    if (deviceHasInternet) {
      AuthRepo.instance.phoneAuth(
        phoneNumber,
      );
    } else {
      isLoading.value = false;
    }
  }

// send mail on registeration
  void sendRegMail() async {
    String receipient = ProfileController.instance.tEmail.text;
    String receipientName = ProfileController.instance.tUserName.text;
    String password = spaceMallSMTPPassword;
    String username = spaceMallEmail;

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'SpaceMall')
      ..recipients.add(receipient)
      ..subject = welcomeSubject
      ..text = "Dear $receipientName, $welcomeMail";

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent:  ${sendReport.toString()}');
    } on MailerException catch (e) {
      debugPrint('Message not sent.');

      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

// send mail on login
  void sendLoginMail() async {
    UserModel? user = await ProfileController.instance.getUserDataFromHive();
    String receipient = user!.email;
    String receipientName = user.userName;
    String password = spaceMallSMTPPassword;
    String username = spaceMallEmail;

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'SpaceMall')
      ..recipients.add(receipient)
      ..subject = loginSubject
      ..text = "Dear $receipientName, $loginMail";

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Message not sent.');

      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
