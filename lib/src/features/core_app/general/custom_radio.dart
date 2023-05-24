import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.onChange,
    required this.color,
    required this.value,
    required this.groupValue,
  });
  final ValueChanged<bool?>? onChange;
  final Color color;
  final bool value;
  final bool groupValue;

  @override
  Widget build(BuildContext context) {
    return Radio(
      toggleable: true,
      activeColor: color,
      value: value,
      groupValue: groupValue,
      onChanged: onChange,
    );
  }
}
