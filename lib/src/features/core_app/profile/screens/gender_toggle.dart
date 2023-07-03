import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';

class GenderToggle extends StatelessWidget {
  GenderToggle({
    super.key,
    required this.isDarkMood,
  });
  final bool isDarkMood;

  final profileController = Get.put(
    ProfileController(),
  );

  List<Widget> _genderButtons() {
    return [
      Obx(
        () => ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          selectedBorderColor:
              isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
          fillColor: isDarkMood ? kMainComplimemtColorLight : kMainColorLight,
          isSelected: profileController.isSelected,
          onPressed: (int index) {
            profileController.isSelected[index] =
                !profileController.isSelected[index];
            if (index == 0) {
              profileController.isSelected
                  .fillRange(0, profileController.genders.length, false);
              profileController.isSelected[index] = true;
              profileController.selectedGender.value =
                  profileController.genders[index];
            } else {
              profileController.isSelected
                  .fillRange(0, profileController.genders.length, false);
              profileController.isSelected[index] = true;
              profileController.selectedGender.value =
                  profileController.genders[index];
            }
          },
          children: <Widget>[
            CircleAvatar(
              backgroundColor: profileController.selectedGender.value == 'Male'
                  ? isDarkMood
                      ? kMainComplimemtColorLight
                      : kMainColorLight
                  : Colors.transparent,
              child: Icon(
                Icons.male,
                color: profileController.selectedGender.value == 'Female'
                    ? isDarkMood
                        ? kMainComplimemtColorLight
                        : kMainComplimemtColorLight
                    : kWhiteLight,
              ),
            ),
            CircleAvatar(
              backgroundColor:
                  profileController.selectedGender.value == 'Female'
                      ? isDarkMood
                          ? kMainComplimemtColorLight
                          : kMainColorLight
                      : Colors.transparent,
              child: Icon(
                Icons.female,
                color: profileController.selectedGender.value == 'Female'
                    ? isDarkMood
                        ? kWhiteLight
                        : kWhiteLight
                    : kMainComplimemtColorLight,
              ),
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _genderButtons(),
    );
  }
}
