import 'package:flutter/material.dart';
import 'package:mybend/core/themes/theme_builder.dart';

final minimalTheme = buildMaterial3Theme(
  seedColor: const Color(0xFF111111),
  brightness: Brightness.light,
  variant: AppThemeVariant.minimal,
);

final lightTheme = buildMaterial3Theme(
  seedColor: Colors.blue,
  brightness: Brightness.light,
);
final greenTheme = buildMaterial3Theme(
  seedColor: Colors.green,
  brightness: Brightness.dark,
);

final glassTheme = buildMaterial3Theme(
  seedColor: const Color(0xFF7DD3FC),
  brightness: Brightness.dark,
  variant: AppThemeVariant.glass,
);

final darkTheme = buildMaterial3Theme(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);
