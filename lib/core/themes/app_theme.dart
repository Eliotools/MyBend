import 'package:flutter/material.dart';

abstract class AppTheme {
  static const textTheme = TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
  );

  static final theme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 26, 4, 148),
      secondary: Color.fromARGB(255, 21, 16, 53),
      brightness: Brightness.dark,
      onPrimary: Colors.grey,
      onSecondary: Colors.orangeAccent,
      error: Colors.red,
      onError: Colors.red,
      surface: Color.fromARGB(255, 5, 1, 27),
      onSurface: Colors.white,
    ),
    textTheme: textTheme,
  );
}
