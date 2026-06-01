import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_colors.dart';

abstract class AppTheme {
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
      onSurface: AppColors.surface,
    ),
  );

  static const textTheme = TextTheme(
    bodyMedium: TextStyle(color: AppColors.secondary),
    titleMedium: TextStyle(color: AppColors.secondary),
  );
}
