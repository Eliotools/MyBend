import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    onSurface: Colors.white,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  ),
  cardTheme: CardThemeData(
      color: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000))),
  useMaterial3: true,
);
