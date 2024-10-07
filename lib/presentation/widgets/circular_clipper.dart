import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Path> {
  final double radius;

  CircularClipper({this.radius = 70.0});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: size.center(Offset.zero), radius: radius));
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) => oldClipper.radius != radius;
}
