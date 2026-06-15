import 'package:flutter/material.dart';
import 'package:mybend/core/themes/theme_builder.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.color,
    this.child,
    this.selected = false,
    this.small = false,
  });

  final Color? color;
  final Widget? child;
  final bool selected;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final variant = context.appThemeVariant;
    final radius = BorderRadius.circular(small ? 12 : 16);

    final background = color ??
        switch (variant) {
          AppThemeVariant.glass => scheme.surfaceContainerHigh,
          AppThemeVariant.minimal => scheme.surface,
          AppThemeVariant.standard => scheme.surfaceContainerHighest,
        };

    return Card(
      margin: EdgeInsets.all(small ? 2 : 4),
      color: background,
      elevation: variant == AppThemeVariant.minimal ? 0 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(small ? 4 : 8),
        child: child,
      ),
    );
  }
}
