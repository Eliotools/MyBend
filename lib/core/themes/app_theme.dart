import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _primary = Color.fromARGB(255, 26, 4, 148);
  static const _darkSurface = Color.fromARGB(255, 5, 1, 27);
  static const _darkSecondary = Color.fromARGB(255, 21, 16, 53);
  static const _lightSurface = Color(0xFFF5F3FF);
  static const _lightSecondary = Color(0xFFE8E4F5);

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final onSurface = isDark ? Colors.white : const Color(0xFF1A1A2E);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: _primary,
      onPrimary: isDark ? Colors.grey : Colors.white,
      secondary: isDark ? _darkSecondary : _lightSecondary,
      onSecondary: isDark ? Colors.orangeAccent : _primary,
      error: Colors.red,
      onError: Colors.white,
      surface: isDark ? _darkSurface : _lightSurface,
      onSurface: onSurface,
    );

    final textTheme = TextTheme(
      bodyLarge: TextStyle(color: onSurface),
      bodyMedium: TextStyle(color: onSurface),
      bodySmall: TextStyle(color: onSurface),
      titleLarge: TextStyle(color: onSurface),
      titleMedium: TextStyle(color: onSurface),
      titleSmall: TextStyle(color: onSurface),
      labelLarge: TextStyle(color: onSurface),
      labelMedium: TextStyle(color: onSurface),
      labelSmall: TextStyle(color: onSurface),
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      useMaterial3: true,
    );
  }
}
