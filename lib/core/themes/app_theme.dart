import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_colors.dart';

abstract class AppTheme {
  static const textTheme = TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  );

  static final theme = ThemeData(
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      brightness: Brightness.dark,
      onPrimary: AppColors.primary,
      onSecondary: AppColors.secondary,
      onTertiary: AppColors.tertiary,
      error: AppColors.error,
      onError: AppColors.error,
      surface: AppColors.surface,
      onSurface: Colors.white,
    ),
    textTheme: textTheme,
  );
}
