import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    // top line
    path.lineTo(size.width, 0);

    // right side
    path.lineTo(size.width, size.height * 0.8);

    // diagonal cut
    path.lineTo(size.width * 0.6, size.height);

    // bottom left
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
