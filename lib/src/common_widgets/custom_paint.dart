import 'package:flutter/material.dart';

// class ShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey // Choose your desired color here
//       ..style = PaintingStyle.fill;

//     final path = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Choose your desired color here
      ..style = PaintingStyle.fill;

    final double radius =
        size.height * 0.2; // Adjust the radius for the circular edges

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.25, size.width, radius)
      ..lineTo(size.width - radius, size.height - radius)
      ..quadraticBezierTo(
          size.width, size.height, size.width * 0.5, size.height)
      ..quadraticBezierTo(0, size.height, radius, size.height - radius)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
