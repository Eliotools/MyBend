import 'package:flutter/material.dart';

/// Liquid glass / glassmorphism theme — frosted surfaces on a deep gradient base.
final glassTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0B1220),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF7DD3FC),
    onPrimary: Color(0xFF0B1220),
    secondary: Color(0xFFA78BFA),
    onSecondary: Colors.white,
    tertiary: Color(0xFF67E8F9),
    surface: Color(0x33FFFFFF),
    onSurface: Color(0xFFF8FAFC),
    surfaceContainerHighest: Color(0x26FFFFFF),
    outline: Color(0x66FFFFFF),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0x26FFFFFF),
    foregroundColor: Color(0xFFF8FAFC),
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    color: const Color(0x33FFFFFF),
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0x55FFFFFF), width: 1.2),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0x667DD3FC),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0x33FFFFFF),
    thickness: 1,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0x26FFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0x44FFFFFF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0x44FFFFFF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF7DD3FC), width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0x99FFFFFF)),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFF8FAFC)),
    bodyMedium: TextStyle(color: Color(0xFFF8FAFC)),
    bodySmall: TextStyle(color: Color(0xCCF8FAFC)),
    titleLarge: TextStyle(color: Color(0xFFF8FAFC)),
    titleMedium: TextStyle(color: Color(0xFFF8FAFC)),
    titleSmall: TextStyle(color: Color(0xFFF8FAFC)),
    labelLarge: TextStyle(color: Color(0xFFF8FAFC)),
    labelMedium: TextStyle(color: Color(0xCCF8FAFC)),
    labelSmall: TextStyle(color: Color(0x99F8FAFC)),
  ),
  extensions: const [GlassThemeExtension()],
);

/// Marks the active theme as glass so widgets can adapt (blur, borders).
class GlassThemeExtension extends ThemeExtension<GlassThemeExtension> {
  const GlassThemeExtension({
    this.isGlass = true,
    this.blurSigma = 24,
    this.borderColor = const Color(0x55FFFFFF),
    this.fillColor = const Color(0x33FFFFFF),
  });

  final bool isGlass;
  final double blurSigma;
  final Color borderColor;
  final Color fillColor;

  @override
  GlassThemeExtension copyWith({
    bool? isGlass,
    double? blurSigma,
    Color? borderColor,
    Color? fillColor,
  }) =>
      GlassThemeExtension(
        isGlass: isGlass ?? this.isGlass,
        blurSigma: blurSigma ?? this.blurSigma,
        borderColor: borderColor ?? this.borderColor,
        fillColor: fillColor ?? this.fillColor,
      );

  @override
  GlassThemeExtension lerp(GlassThemeExtension? other, double t) {
    if (other == null) return this;
    return GlassThemeExtension(
      isGlass: t < 0.5 ? isGlass : other.isGlass,
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
    );
  }
}

extension GlassThemeContext on BuildContext {
  GlassThemeExtension? get glassTheme =>
      Theme.of(this).extension<GlassThemeExtension>();
}
