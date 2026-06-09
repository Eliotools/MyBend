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
      primary: Colors.grey,
      secondary: Colors.orangeAccent,
      brightness: Brightness.dark,
      onPrimary: Colors.grey,
      onSecondary: Colors.orangeAccent,
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    textTheme: textTheme,
  );
}
