import 'package:flutter/material.dart';

class SquareBGCustomPaint extends StatelessWidget {
  Widget child;

  SquareBGCustomPaint({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DrawingBookPainter(),
      child: child,
    );
  }
}

class DrawingBookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1.0;

    final double step = 15.0; // Adjust the spacing between lines
    final double maxX = size.width;
    final double maxY = size.height;

    // Drawing vertical lines
    for (double i = 0; i <= maxX; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, maxY), paint);
    }

    // Drawing horizontal lines
    for (double i = 0; i <= maxY; i += step) {
      canvas.drawLine(Offset(0, i), Offset(maxX, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

BoxDecoration kMainButtonContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(5, 5),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ],
);

ButtonStyle kMainButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(8.0),
  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent.shade400),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(width: 1, color: Colors.black),
    ),
  ),
  minimumSize: MaterialStateProperty.all(
    const Size(300, 50),
  ),
);


BoxDecoration kMainTextFieldBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(
      10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(
          5, 5),
      blurRadius: 0,
      spreadRadius:
      0,
    ),
  ],
);


InputDecoration MainTextFieldInputDecoration(String? label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(letterSpacing: 3),
    filled: true,
    fillColor: Colors
        .white,
    border: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1,
          color: Colors
              .black),
      borderRadius: BorderRadius.circular(
          10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1,
          color: Colors
              .black),
      borderRadius: BorderRadius.circular(
          10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1,
          color: Colors
              .black),
      borderRadius: BorderRadius.circular(
          10),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 10),
  );
}

BoxDecoration kTaskContainerBoxDecoration = BoxDecoration(
  color: Colors.greenAccent.shade100,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
    color: Colors.black,
    width: 1,
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(3, 3),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ],
);