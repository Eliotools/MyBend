import 'package:flutter/material.dart';

class CustomColorScheme {
  const CustomColorScheme(this.colors);

  final List<Color> colors;

  static const defaultScheme = CustomColorScheme([
    //#69D2E7
    Color.fromRGBO(85, 98, 112, 1),
    Color.fromRGBO(78, 205, 196, 1),
    Color.fromRGBO(199, 244, 100, 1),
    Color.fromRGBO(255, 107, 107, 1),
    Color.fromRGBO(196, 77, 88, 1),
  ]);

  Color at(int index) => colors[index % colors.length];
}
