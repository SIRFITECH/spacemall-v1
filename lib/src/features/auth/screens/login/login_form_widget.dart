import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
    loginController.phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: loginController.phoneController.text.length,
      ),
    );

    return Form(
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
          border: Theme.of(context).inputDecorationTheme.border,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kCoutryCodeVertical,
              horizontal: kCoutryCodeHorizontal,
            ),
            child: InkWell(
                onTap: () => loginController.setPickedCountry(context),
                child: Obx(
                  () => Text(
                    '${loginController.country.value.flagEmoji} + ${loginController.country.value.phoneCode} |',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                )),
          ),
          suffixIcon: loginController.phoneController.text.length > 9
              ? Padding(
                  padding: const EdgeInsets.all(kFormPadding),
                  child: Container(
                    height: kFormHeight - 10,
                    width: kFormHeight - 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(kFormBorderRadius),
                    ),
                    child: const Icon(
                      Icons.done,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
