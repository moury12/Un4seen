import 'package:flutter/material.dart';

class StoryTextItem {
  String text;
  Offset position;
  Color color;
  double fontSize;

  StoryTextItem({
    required this.text,
    required this.position,
    this.color = Colors.white,
    this.fontSize = 24,
  });
}