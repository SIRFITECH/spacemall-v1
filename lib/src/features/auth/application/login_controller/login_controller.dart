import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  RxString phone = ''.obs;
  TextEditingController phoneController = TextEditingController();

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
    print(phone.value);
  }

  void signUserInWithPhone(String phoneNumber) {
    AuthRepo.instance.phoneAuth(
      phoneNumber,
    );
  }
}
