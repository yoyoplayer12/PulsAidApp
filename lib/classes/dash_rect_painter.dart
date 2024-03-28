import 'package:flutter/material.dart';

class DashRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var dashWidth = 5.0;
    var dashSpace = 5.0;
    var dashCountWidth = (size.width / (dashWidth + dashSpace)).floor();
    var dashCountHeight = (size.height / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCountWidth; ++i) {
      // Draw from left to right
      canvas.drawLine(Offset(i * (dashWidth + dashSpace), 0), Offset(i * (dashWidth + dashSpace) + dashWidth, 0), paint);
      // Draw from right to left
      canvas.drawLine(Offset(i * (dashWidth + dashSpace), size.height), Offset(i * (dashWidth + dashSpace) + dashWidth, size.height), paint);
    }

    for (int i = 0; i < dashCountHeight; ++i) {
      // Draw from top to bottom
      canvas.drawLine(Offset(0, i * (dashWidth + dashSpace)), Offset(0, i * (dashWidth + dashSpace) + dashWidth), paint);
      // Draw from bottom to top
      canvas.drawLine(Offset(size.width, i * (dashWidth + dashSpace)), Offset(size.width, i * (dashWidth + dashSpace) + dashWidth), paint);
    }

    // Check if there's enough space for a half dash at the end
    if (size.width - (dashCountWidth * (dashWidth + dashSpace)) >= dashWidth) {
      canvas.drawLine(Offset(dashCountWidth * (dashWidth + dashSpace), 0), Offset(size.width, 0), paint);
      canvas.drawLine(Offset(dashCountWidth * (dashWidth + dashSpace), size.height), Offset(size.width, size.height), paint);
    }
    if (size.height - (dashCountHeight * (dashWidth + dashSpace)) >= dashWidth) {
      canvas.drawLine(Offset(0, dashCountHeight * (dashWidth + dashSpace)), Offset(0, size.height), paint);
      canvas.drawLine(Offset(size.width, dashCountHeight * (dashWidth + dashSpace)), Offset(size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}