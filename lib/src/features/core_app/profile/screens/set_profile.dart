import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/custom_button.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/screens/gender_toggle.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';

class SetProfile extends StatelessWidget {
  const SetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final profileController = Get.put(
      ProfileController(),
    );

    final profileRepo = ProfileRepo.instance;
    var image = profileController.profilePic;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Set Profile',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.width * 0.1),
              child: Column(
                children: [
                  Obx(
                    () => GestureDetector(
                        onTap: () {
                          profileController.selectImage(context);
                          debugPrint(
                              'Select Image: ${profileController.profilePic}');
                        },
                        child: image.value == null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: isDarkMood
                                      ? kMainComplimemtColorLight
                                          .withOpacity(0.2)
                                      : kMainColorDark.withOpacity(0.2),
                                  child: SizedBox(
                                    child: ClipOval(
                                      child: Padding(
                                        padding: const EdgeInsets.all(34.0),
                                        child: SvgPicture.asset(
                                          kProfileIcon,
                                          color: isDarkMood
                                              ? kMainComplimemtColorLight
                                              : kMainColorLight,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(image.value!),
                              )),
                  ),
                  Text(
                    kChangeLogoText,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            ),
            Row(
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tFName,
                  keyboardType: TextInputType.name,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kFNameText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tLName,
                  keyboardType: TextInputType.name,
                  width: screenSize.width * 0.42,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kLNameText,
                  maxLines: 1,
                )
              ],
            ),
            TextFeildWidget(
              screenSize: screenSize,
              isDarkMood: isDarkMood,
              controller: profileController.tEmail,
              keyboardType: TextInputType.emailAddress,
              width: screenSize.width * 0.84,
              height: screenSize.width * 0.1,
              hintText: '',
              labelText: kEmailText,
              maxLines: 1,
            ),
            TextFeildWidget(
              screenSize: screenSize,
              isDarkMood: isDarkMood,
              controller: profileController.tHomeAddress,
              keyboardType: TextInputType.streetAddress,
              hintText: '',
              labelText: kHomeText,
              maxLines: 4,
              width: screenSize.width * 0.84,
              height: screenSize.width * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tDOB,
                  keyboardType: TextInputType.datetime,
                  height: screenSize.width * 0.1,
                  hintText: kDOBHintText,
                  labelText: kDOBText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.width * 0.02),
                      child: Text(
                        kGenderText,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.05,
                        ),
                        Text(
                          'M',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.1,
                        ),
                        Text(
                          'F',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenSize.width * 0.15),
                      child: GenderToggle(),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tContact,
                  keyboardType: TextInputType.phone,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kContactText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tWhatsApp,
                  keyboardType: TextInputType.phone,
                  width: screenSize.width * 0.42,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kWhatsAppText,
                  maxLines: 1,
                )
              ],
            ),
            Row(
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tState,
                  keyboardType: TextInputType.text,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kStateText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tCity,
                  keyboardType: TextInputType.text,
                  width: screenSize.width * 0.42,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kCityText,
                  maxLines: 1,
                )
              ],
            ),
            Row(
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tCountry,
                  keyboardType: TextInputType.text,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kCountryText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tZipCode,
                  keyboardType: TextInputType.phone,
                  width: screenSize.width * 0.42,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kZipCodeText,
                  maxLines: 1,
                )
              ],
            ),
            Row(
              children: [
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tBankName,
                  keyboardType: TextInputType.text,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kBankNameText,
                  maxLines: 1,
                  width: screenSize.width * 0.42,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFeildWidget(
                  screenSize: screenSize,
                  isDarkMood: isDarkMood,
                  controller: profileController.tAccount,
                  keyboardType: TextInputType.phone,
                  width: screenSize.width * 0.42,
                  height: screenSize.width * 0.1,
                  hintText: '',
                  labelText: kAccountText,
                  maxLines: 1,
                )
              ],
            ),
            TextFeildWidget(
              screenSize: screenSize,
              isDarkMood: isDarkMood,
              controller: profileController.tBio,
              keyboardType: TextInputType.text,
              width: screenSize.width * 0.84,
              height: screenSize.width * 0.1,
              hintText: '',
              labelText: kBioText,
              maxLines: 5,
            ),
            TextFeildWidget(
              screenSize: screenSize,
              isDarkMood: isDarkMood,
              controller: profileController.tJobTitle,
              keyboardType: TextInputType.text,
              hintText: '',
              labelText: kJobTitleText,
              maxLines: 1,
              width: screenSize.width * 0.84,
              height: screenSize.width * 0.1,
            ),
            TextFeildWidget(
              screenSize: screenSize,
              isDarkMood: isDarkMood,
              controller: profileController.tAlternativeEmail,
              keyboardType: TextInputType.emailAddress,
              hintText: '',
              labelText: kAlternativeEmailText,
              maxLines: 1,
              width: screenSize.width * 0.84,
              height: screenSize.width * 0.1,
            ),
            CustomButton(
              screenSize: screenSize,
              onPress: () => profileRepo.saveData(context),
              title: kSave,
              width: screenSize.width * 0.3,
            )
          ],
        ),
      ),
    );
  }
}
