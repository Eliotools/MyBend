import 'package:flutter/material.dart';

enum AppThemeVariant { standard, glass, minimal }

class AppThemeStyle extends ThemeExtension<AppThemeStyle> {
  const AppThemeStyle({required this.variant});

  final AppThemeVariant variant;

  @override
  AppThemeStyle copyWith({AppThemeVariant? variant}) =>
      AppThemeStyle(variant: variant ?? this.variant);

  @override
  AppThemeStyle lerp(AppThemeStyle? other, double t) {
    if (other == null) return this;
    return t < 0.5 ? this : other;
  }
}

extension AppThemeStyleContext on BuildContext {
  AppThemeVariant get appThemeVariant =>
      Theme.of(this).extension<AppThemeStyle>()?.variant ??
      AppThemeVariant.standard;
}

ThemeData buildMaterial3Theme({
  required Color seedColor,
  required Brightness brightness,
  AppThemeVariant variant = AppThemeVariant.standard,
}) {
  final baseScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );

  final colorScheme = switch (variant) {
    AppThemeVariant.glass => baseScheme.copyWith(
        surface: const Color(0xFF0B1220),
        surfaceContainerHighest: const Color(0x33FFFFFF),
        surfaceContainerHigh: const Color(0x26FFFFFF),
        outline: const Color(0x66FFFFFF),
        primary: const Color(0xFF7DD3FC),
        onPrimary: const Color(0xFF0B1220),
      ),
    AppThemeVariant.minimal => baseScheme.copyWith(
        surface: Colors.white,
        surfaceContainerHighest: const Color(0xFFF3F4F6),
        outline: const Color(0xFFE5E7EB),
        primary: const Color(0xFF111111),
        onPrimary: Colors.white,
      ),
    AppThemeVariant.standard => baseScheme,
  };

  final radius =
      BorderRadius.circular(variant == AppThemeVariant.minimal ? 8 : 12);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: switch (variant) {
      AppThemeVariant.glass => const Color(0xFF0B1220),
      AppThemeVariant.minimal => const Color(0xFFFAFAFA),
      AppThemeVariant.standard => colorScheme.surface,
    },
    listTileTheme: const ListTileThemeData(
      subtitleTextStyle: TextStyle(fontSize: 10),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: variant == AppThemeVariant.minimal ? 0 : 1,
      color: colorScheme.surfaceContainerHighest,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      margin: const EdgeInsets.all(4),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: radius),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 2,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: radius),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      showDragHandle: true,
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
    ),
    extensions: [AppThemeStyle(variant: variant)],
  );
}
