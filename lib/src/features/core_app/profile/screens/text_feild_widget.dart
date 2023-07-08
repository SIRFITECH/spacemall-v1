import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/profile/application/date_widget_controller.dart';

class TextFeildWidget extends StatelessWidget {
  const TextFeildWidget({
    super.key,
    required this.screenSize,
    required this.isDarkMood,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.labelText,
    required this.maxLines,
    required this.height,
    required this.width,
  });

  final Size screenSize;
  final bool isDarkMood;
  final TextEditingController controller;
  final keyboardType;
  final String hintText;
  final String labelText;
  final int maxLines;
  final dynamic height;
  final dynamic width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.02),
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: isDarkMood
                      ? kTextFieldLightBorderColor
                      : kTextFieldDarkBorderColor,
                  width: 0.1,
                )),
                fillColor: isDarkMood ? kTextFieldDarkColor : kWhiteDark,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: kGreyColor),
              ),
              style: Theme.of(context).textTheme.labelSmall,
              keyboardType: keyboardType,
              controller: controller,
              maxLines: maxLines),
        ),
      ],
    );
  }
}

// date inputfield
class DateFeildWidget extends StatelessWidget {
  DateFeildWidget({
    super.key,
    required this.screenSize,
    required this.isDarkMood,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.labelText,
    required this.maxLines,
    required this.height,
    required this.width,
    // required this.onTap,
  });

  final Size screenSize;
  final bool isDarkMood;
  final TextEditingController controller;
  final keyboardType;
  final String hintText;
  final String labelText;
  final int maxLines;
  final dynamic height;
  final dynamic width;
  // final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DateFieldController dateFieldController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.02),
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        SizedBox(
            height: height,
            width: width,
            child: Obx(
              () => TextFormField(
                onTap: () async {
                  dateFieldController.toggleDate();

                  DateTime selectedDate =
                      await dateFieldController.pickDate(context);

                  // ignore: unnecessary_null_comparison
                  if (selectedDate != null) {
                    controller.text =
                        DateFormat('dd-MM-yyyy').format(selectedDate);
                  }
                  print('tap is ${dateFieldController.isTapped.value}');
                },
                readOnly: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: dateFieldController.isTapped.value
                        ? isDarkMood
                            ? kDarkModeIconColor
                            : kMainColorDark
                        : kGreyColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMood
                          ? kTextFieldLightBorderColor
                          : kTextFieldDarkBorderColor,
                      width: 0.1,
                    ),
                  ),
                  fillColor: isDarkMood ? kTextFieldDarkColor : kWhiteDark,
                  filled: true,
                  contentPadding: const EdgeInsets.only(top: 10, left: 10),
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.labelSmall,
                ),
                style: Theme.of(context).textTheme.labelSmall,
                keyboardType: keyboardType,
                controller: controller,
              ),
            ))
      ],
    );
  }
}
