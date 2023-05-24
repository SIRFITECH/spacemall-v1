import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider(
      {super.key,
      required this.height,
      required this.thickness,
      required this.color,
      required this.margin});
  final double height;
  final double thickness;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
        child: Divider(
          height: height,
          thickness: thickness,
          color: color,
        ),
      ),
    );
  }
}
