import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF69D2E7);
  static const secondary = Color(0xFFA7DBD8);
  static const tertiary = Color(0xFFE0E4CC);
  static const error = Color(0xFFFA6900);
  static const surface = Color(0xFF000000);
  static final containersColor = {
    'green': const Color.fromRGBO(85, 98, 112, 1),
    'blue': const Color.fromRGBO(78, 205, 196, 1),
    'yellow': const Color.fromRGBO(199, 244, 100, 1),
    'orange': const Color.fromRGBO(255, 107, 107, 1),
    'red': const Color.fromRGBO(196, 77, 88, 1),
  };
}
