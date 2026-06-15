import 'package:flutter/material.dart';

/// Minimal UI — flat, neutral, high whitespace, no visual noise.
final minimalTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF111111),
    onPrimary: Colors.white,
    secondary: Color(0xFF6B7280),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF111111),
    surfaceContainerHighest: Color(0xFFF3F4F6),
    outline: Color(0xFFE5E7EB),
    error: Color(0xFFDC2626),
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFAFAFA),
    foregroundColor: Color(0xFF111111),
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF111111),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFE5E7EB),
    thickness: 1,
    space: 1,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF111111), width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF111111)),
    bodyMedium: TextStyle(color: Color(0xFF111111)),
    bodySmall: TextStyle(color: Color(0xFF6B7280)),
    titleLarge: TextStyle(color: Color(0xFF111111), fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: Color(0xFF111111), fontWeight: FontWeight.w500),
    titleSmall: TextStyle(color: Color(0xFF374151)),
    labelLarge: TextStyle(color: Color(0xFF111111)),
    labelMedium: TextStyle(color: Color(0xFF6B7280)),
    labelSmall: TextStyle(color: Color(0xFF9CA3AF)),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF374151)),
  extensions: const [MinimalThemeExtension()],
);

class MinimalThemeExtension extends ThemeExtension<MinimalThemeExtension> {
  const MinimalThemeExtension({this.isMinimal = true});

  final bool isMinimal;

  @override
  MinimalThemeExtension copyWith({bool? isMinimal}) =>
      MinimalThemeExtension(isMinimal: isMinimal ?? this.isMinimal);

  @override
  MinimalThemeExtension lerp(MinimalThemeExtension? other, double t) {
    if (other == null) return this;
    return t < 0.5 ? this : other;
  }
}

extension MinimalThemeContext on BuildContext {
  MinimalThemeExtension? get minimalTheme =>
      Theme.of(this).extension<MinimalThemeExtension>();
}
