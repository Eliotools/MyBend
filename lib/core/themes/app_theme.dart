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
      primary: Color.fromARGB(255, 238, 212, 177),
      secondary: Color.fromARGB(255, 95, 22, 0),
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
