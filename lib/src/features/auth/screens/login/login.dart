import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/screens/login/f_login.dart';
import 'package:spacemall/src/features/auth/screens/login/login_or_widget.dart';
import 'package:spacemall/src/features/auth/screens/otp/otp_screen.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';

import '../../../../constants/colors.dart';
import '../../application/login_controller/login_controller.dart';
import 'login_text_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenSize = media.size;
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;

    // Get.put(StoreController());
    final LoginController loginController = Get.find();

    return Scaffold(
      backgroundColor: isDarkMood ? kDarkThemeBgColor : kLightThemeBgColor,
      body: GetBuilder<OtpController>(
        init: OtpController(),
        builder: (otpController) {
          // if (OtpController.instance.isLoading.value) {
          //   Positioned(
          //     child: Container(
          //         height: screenSize.height,
          //         width: screenSize.width,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: Colors.black.withOpacity(0.5),
          //         ),
          //         child: const Center(
          //           child: CircularProgressIndicator(),
          //         )),
          //   );
          // }
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultSize),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kBackGroundAfrica),
                    fit: BoxFit.contain,
                  ),
                ),
                child: ListView(
                  children: [
                    Image(
                      height: screenSize.height * 0.4,
                      image: const AssetImage(kLoginIllustration),
                    ),
                    const LoginText(),
                    Padding(
                      padding: const EdgeInsets.all(kFormHeight - 10),
                      // login FOrm
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: loginController.phoneController,
                          style: Theme.of(context).textTheme.labelSmall,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'You have to enter a phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: kLoginPlaceHolderText.toUpperCase(),
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: kCoutryCodeVertical,
                                horizontal: kCoutryCodeHorizontal,
                              ),
                              child: InkWell(
                                  onTap: () =>
                                      loginController.setPickedCountry(context),
                                  child: Obx(
                                    () => Text(
                                      '${loginController.country.value.flagEmoji} + ${loginController.country.value.phoneCode} |',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  )),
                            ),
                            suffixIcon:
                                loginController.phoneController.text.length > 9
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.all(kFormPadding),
                                        child: Container(
                                          height: kFormHeight - 10,
                                          width: kFormHeight - 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                                kFormBorderRadius),
                                          ),
                                          child: const Icon(
                                            Icons.done,
                                          ),
                                        ),
                                      )
                                    : null,
                          ),
                        ),
                      ),
                      //Login form end
                    ),
                    // Login Button

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kCoutryCodeHorizontal + 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ProfileController.instance.contactNumber =
                                  '+${loginController.country.value.phoneCode}${loginController.phoneController.text.trim()}';
                              loginController.signUserInWithPhone(
                                '+${loginController.country.value.phoneCode}${loginController.phoneController.text.trim()}',
                              );
                              ProfileController.instance.contactNumber =
                                  '+${loginController.country.value.phoneCode}${loginController.phoneController.text.trim()}';
                              OtpController.instance.setTimer();
                              Get.off(
                                () => const OTPScreen(),
                              );
                              // AuthRepo.instance.userAlreadyExists(
                              //     '+${loginController.country.value.phoneCode}${loginController.phoneController.text.trim()}');
                            }
                          },
                          child: const Text(
                            kLoginText,
                          ),
                        ),
                      ),
                    ),
                    // Login Button stops hear
                    const LoginOr(),
                    const FLogin(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final _formKey = GlobalKey<FormState>();
