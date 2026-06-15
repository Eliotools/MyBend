import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/core/themes/dark_theme.dart';
import 'package:mybend/core/themes/green_theme.dart';
import 'package:mybend/core/themes/light_theme.dart';
import 'package:mybend/core/themes/purple_theme.dart';
import 'package:mybend/core/themes/red_theme.dart';

const themeKeys = ['dark', 'light', 'red', 'purple', 'green'];

final Map<String, ThemeData> colorMap = {
  'dark': darkTheme,
  'light': lightTheme,
  'red': redTheme,
  'purple': purpleTheme,
  'green': greenTheme,
};

class ThemeCubit extends Cubit<String> {
  ThemeCubit()
      : _localStorageRepository = getIt<LocalStorageRepository>(),
        super('dark');

  final LocalStorageRepository _localStorageRepository;

  ThemeData get currentTheme => colorMap[state] ?? darkTheme;
  ThemeMode get currentThemeMode => ThemeMode.dark;

  Future<void> load() async {
    final value =
        await _localStorageRepository.getValue(LocalStorageKey.themeMode);
    emit(colorMap.containsKey(value) ? value! : 'dark');
  }

  Future<void> toggle() async {
    final currentIndex = themeKeys.indexOf(state);
    final nextKey = themeKeys[(currentIndex + 1) % themeKeys.length];
    await _setThemeMode(nextKey);
  }

  Future<void> setThemeMode(String key) async {
    if (!colorMap.containsKey(key)) return;
    await _setThemeMode(key);
  }

  Future<void> _setThemeMode(String key) async {
    await _localStorageRepository.setValue(LocalStorageKey.themeMode, key);
    emit(key);
  }
}
