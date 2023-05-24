import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.screenSize,
    required this.onPress,
    required this.title,
    required this.width,
  });

  final Size screenSize;
  final VoidCallback onPress;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.05),
      child: Row(
        children: [
          SizedBox(
            width: width,
            child: ElevatedButton(
              onPressed: onPress,
              child: Text(title),
            ),
          ),
        ],
      ),
    );
  }
}
