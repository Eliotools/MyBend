import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/core/theme/theme_cubit.dart';

const themeIconMap = {
  'dark': Icons.bedtime,
  'light': Icons.light_mode_outlined,
  'green': Icons.forest,
  'minimal': Icons.horizontal_rule,
  'glass': Icons.blur_on,
};

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, themeKey) => GestureDetector(
        onTap: getIt<ThemeCubit>().toggle,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Tooltip(
            message: 'Theme: $themeKey',
            child: Icon(themeIconMap[themeKey] ?? Icons.palette),
          ),
        ),
      ),
    );
  }
}
