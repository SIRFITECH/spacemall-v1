import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';

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
                hintStyle: Theme.of(context).textTheme.labelSmall,
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
